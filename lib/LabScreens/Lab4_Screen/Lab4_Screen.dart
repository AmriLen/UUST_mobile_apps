import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

import 'package:uust_mobile_apps/drawer.dart';
import 'package:uust_mobile_apps/constants.dart';


class HistoryItem {
  final String imagePath;
  final String label;
  final double confidence;

  HistoryItem(this.imagePath, this.label, this.confidence);
}

class Lab4 extends StatefulWidget {
  const Lab4({Key? key}) : super(key: key);

  @override
  State<Lab4> createState() => _Lab4State();
}

class _Lab4State extends State<Lab4> {
  bool isLoading = false;
  String loadingMessage = "Загружаем данные...";
  String? errorMessage;

  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isCameraReady = false;
  bool _isPickingImage = false;

  late Interpreter _interpreter;

  List<HistoryItem> history = [];

  // ────────────────────────────────────────────────
  // Жизненный цикл
  // ────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    initCamera();
    loadModel();
  }

  @override
  void dispose() {
    _interpreter.close();
    _controller?.dispose();
    super.dispose();
  }

  // ────────────────────────────────────────────────
  // Загрузка модели
  // ────────────────────────────────────────────────

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/model.tflite');
  }

  // ────────────────────────────────────────────────
  // Инициализация камеры
  // ────────────────────────────────────────────────

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();
      _controller = CameraController(cameras![0], ResolutionPreset.medium);

      await _controller!.initialize();

      setState(() {
        isCameraReady = true;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Ошибка камеры: $e";
      });
    }
  }

  // ────────────────────────────────────────────────
  // Обработка фото
  // ────────────────────────────────────────────────

  Future<void> takePhoto() async {
    if (!_controller!.value.isInitialized) return;

    try {
      final image = await _controller!.takePicture();

      setState(() {
        isLoading = true;
        loadingMessage = "Анализируем гриб...";
      });

      final result = await classifyImage(image.path);

      saveToHistory(image.path, result);

      setState(() {
        isLoading = false;
      });

      showResult(result);
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Ошибка съемки";
      });
    }
  }

  // ────────────────────────────────────────────────
  // ИИ распознование
  // ────────────────────────────────────────────────

  Future<Map<String, dynamic>> classifyImage(String path) async {
    // 1. читаем изображение
    final imageBytes = File(path).readAsBytesSync();
    img.Image? originalImage = img.decodeImage(imageBytes);

    if (originalImage == null) {
      throw Exception("Не удалось декодировать изображение");
    }

    // 2. ресайз ПОД МОДЕЛЬ (360!)
    img.Image resizedImage = img.copyResize(
      originalImage,
      width: 360,
      height: 360,
    );

    // 3. создаём input tensor (uint8)
    var input = List.generate(
      1,
      (i) => List.generate(
        360,
        (y) => List.generate(
          360,
          (x) {
            final pixel = resizedImage.getPixel(x, y);

            return [
              pixel.r,   // ❗ БЕЗ /255
              pixel.g,
              pixel.b,
            ];
          },
        ),
      ),
    );

    // ❗ ВАЖНО: тип должен быть int
    var inputUint8 = input.map((batch) => batch.map((row) =>
        row.map((col) => col.map((v) => v?.toInt()).toList()).toList()
    ).toList()).toList();

    // 4. output (пример: 3 класса — поменяй если нужно)
    var output = List.filled(3, 0).reshape([1, 3]);

    // 5. запуск модели
    _interpreter.run(inputUint8, output);

    // 6. анализ результата
    final scores = output[0];

    int maxIndex = 0;
    int maxScore = scores[0];

    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > maxScore) {
        maxScore = scores[i];
        maxIndex = i;
      }
    }

    // 7. нормализуем (если модель не softmax)
    double confidence = maxScore / 255.0;
    print(scores);

    const labels = [
      "Несъедобный",
      "Сомнительный",
      "Съедобный",
    ];

    return {
      "label": labels[maxIndex],
      "confidence": confidence,
    };
  }

  // ────────────────────────────────────────────────
  // Сохранение истории
  // ────────────────────────────────────────────────

  void saveToHistory(String path, Map result) {
    history.insert(
      0,
      HistoryItem(
        path,
        result["label"],
        result["confidence"],
      ),
    );
  }

  // ────────────────────────────────────────────────
  // Отображение результата
  // ────────────────────────────────────────────────

  String getRiskLevel(double confidence, String label) {
    if (label == "Несъедобный") return "🔴 Опасно";
    if (confidence < 0.6) return "🟡 Не уверен";
    return "🟢 Можно";
  }

  void showResult(Map result) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(result["label"]),
        content: Text(
          "${getRiskLevel(result["confidence"], result["label"])}\n"
          "Вероятность: ${(result["confidence"] * 100).toStringAsFixed(1)}%",
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────
  // Функция выбора изображения
  // ────────────────────────────────────────────────

  Future<void> pickImage() async {
    if (_isPickingImage) return;
    _isPickingImage = true;

    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final result = await classifyImage(image.path);

      saveToHistory(image.path, result);

      if (!mounted) return;

      showResult(result);

    } catch (e) {
      debugPrint("Ошибка ImagePicker: $e");
    } finally {
      _isPickingImage = false; // 👈 обязательно сбрасываем
    }
  }

  // ────────────────────────────────────────────────
  // Главный билд
  // ────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: Text('ИИ распознавание', style: unbReg)),
      body: errorMessage != null
          ? customErrorWidget(errorMessage!)
          : isLoading == true
          ? customLoadingWidget(loadingMessage)
          : Stack(
              alignment:AlignmentGeometry.center,
              children: [
                isCameraReady
                  ? CameraPreview(_controller!)
                  : Center(child: CircularProgressIndicator()),
                
                Positioned(
                  bottom: 140,
                  child: Row(
                    spacing: 60,
                    children: [

                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => HistorySheet(history: history),
                          );
                          print(_interpreter.getInputTensor(0).shape);
                          print(_interpreter.getInputTensor(0).type);
                          print(_interpreter.getOutputTensor(0).shape);
                        }, // * кнопка просмотра истории
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: const [
                              BoxShadow(blurRadius: 6, color: Colors.black26),
                            ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.history_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: takePhoto, // * кнопка камеры
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: const [
                              BoxShadow(blurRadius: 6, color: Colors.black26),
                            ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.camera_alt,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          if (!_isPickingImage) {
                            pickImage();
                          }
                        }, // * кнопка добавления изображения
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: const [
                              BoxShadow(blurRadius: 6, color: Colors.black26),
                            ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.add_photo_alternate,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    ]
                  )
                ),


                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    height: 90,
                    color: Colors.black45,
                    child: Text(
                      textAlign: TextAlign.center,
                      "⚠️ ИИ может допускать ошибки. Проверяйте важную информацию",
                      style: unbRegW,
                    ),
                  )
                ),
              ],
            ),
    );
  }
}

  // ────────────────────────────────────────────────
  // Нижняя панель с историей
  // ────────────────────────────────────────────────

class HistorySheet extends StatelessWidget {
  final List<HistoryItem> history;

  const HistorySheet({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(16),
      child: history.isEmpty
          ? Center(child: Text("История пуста"))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];

                return Card(
                  child: ListTile(
                    leading: Image.file(File(item.imagePath)),
                    title: Text(item.label),
                    subtitle: Text(
                      "Уверенность: ${(item.confidence * 100).toStringAsFixed(1)}%",
                    ),
                  ),
                );
              },
            ),
    );
  }
}