import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:uust_mobile_apps/drawer.dart';
import 'package:uust_mobile_apps/constants.dart';


class Lab1 extends StatefulWidget {
  const Lab1({Key? key}) : super(key: key);

  @override
  State<Lab1> createState() => _Lab1State();
}

class _Lab1State extends State<Lab1> {
  LatLng? currentPosition;
  double _speed = 0.0;          // м/с
  double _bearing = 0.0;        // направление движения
  bool _isMoving = false;
  bool _autoCenter = true;
  bool _mapReady = false;
  double _mapRotation = 0.0;    // угол поворота карты
  int _steps = 0;
  int _stepsOffset = 0;         // шаги с момента открытия страницы
  bool _isPedometerAvailable = false;
  

  String loadingMessage = "Получаем данные геолокации...";
  String? errorMessage;

  final MapController mapController = MapController();

  StreamSubscription<StepCount>? _stepSubscription;
  StreamSubscription<Position>? _positionSubscription;
  StreamSubscription<CompassEvent>? _compassSubscription;

  // ────────────────────────────────────────────────
  // Жизненный цикл
  // ────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _initLocation();
    _initCompass();
    _initPedometer();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _compassSubscription?.cancel();
    _stepSubscription?.cancel();
    super.dispose();
  }

  // ────────────────────────────────────────────────
  // Педометр
  // ────────────────────────────────────────────────

  Future<void> _initPedometer() async {
    // На Android 10+ нужно разрешение
    if (Platform.isAndroid) {
      final status = await Permission.activityRecognition.request();
      if (status.isDenied) return;
    }

    _stepSubscription = Pedometer.stepCountStream.listen(
      (StepCount event) {
        if (!mounted) return;
        setState(() {
          if (_stepsOffset == 0) _stepsOffset = event.steps;
          _steps = event.steps - _stepsOffset;
          _isPedometerAvailable = true;
        });
      },
      onError: (_) {
        if (mounted) setState(() => _isPedometerAvailable = false);
      },
    );
  }

  // ────────────────────────────────────────────────
  // Геолокация
  // ────────────────────────────────────────────────

  Future<void> _initLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) setState(() => errorMessage = "Геолокация отключена на устройстве.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (mounted) setState(() => errorMessage = "Нет разрешения на доступ к геолокации.");
      return;
    }

    final locationSettings = Platform.isAndroid
    ? AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
        intervalDuration: const Duration(milliseconds: 500),
      )
    : AppleSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
        activityType: ActivityType.automotiveNavigation,
        pauseLocationUpdatesAutomatically: false,
      );

    _positionSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen(_onPositionUpdate, onError: _onLocationError);
  }

  void _onPositionUpdate(Position position) {
    if (!mounted) return;

    final newPos = LatLng(position.latitude, position.longitude);
    final speed = position.speed < 0 ? 0.0 : position.speed;

    setState(() {
      currentPosition = newPos;
      _speed = speed;
      _bearing = position.heading;
      _isMoving = speed > 0.5;
    });

    if (_autoCenter && _mapReady) {
      mapController.move(newPos, mapController.camera.zoom);
    }
  }

  void _onLocationError(Object error) {
    if (mounted) setState(() => errorMessage = "Ошибка геолокации: $error");
  }

  // ────────────────────────────────────────────────
  // Компас
  // ────────────────────────────────────────────────

  void _initCompass() {
    _compassSubscription = FlutterCompass.events?.listen((event) {
      if (!mounted) return;
    });
  }

  void _alignNorth() {
    _mapRotation = 0.0;
    if (_mapReady) {
      mapController.rotate(0);
    }
  }

  // ────────────────────────────────────────────────
  // Вспомогательные методы
  // ────────────────────────────────────────────────

  void _centerOnMe() {
    if (currentPosition != null && _mapReady) {
      setState(() => _autoCenter = true);
      mapController.move(currentPosition!, mapController.camera.zoom);
    }
  }

  String _getDirectionLabel(double bearing) {
    const directions = [
      'На север', 'На северо-восток', 'На восток', 'На юго-восток',
      'На юг', 'На юго-запад', 'На запад', 'На северо-запад',
    ];
    final index = ((bearing + 22.5) / 45).floor() % 8;
    return directions[index];
  }

  String _formatSpeed(double speedMs) {
    final kmh = (speedMs * 3.6).round();
    return '$kmh км/ч';
  }

  // ────────────────────────────────────────────────
  // UI
  // ────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: const Text('ЛР1: Геолокация и датчики')),
      body: errorMessage != null
          ? customErrorWidget(errorMessage!)
          : currentPosition == null
              ? customLoadingWidget(loadingMessage)
              : Stack(
                  children: [
                    // ── Карта ──────────────────────────────────────
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        initialCenter: currentPosition!,
                        initialZoom: 15,
                        onMapReady: () {
                          setState(() => _mapReady = true);
                        },
                        onPositionChanged: (position, hasGesture) {
                          if (hasGesture) {
                            setState(() => _autoCenter = false);
                          }
                          setState(() => _mapRotation = position.rotation);
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: 'com.example.uust_mobile_apps',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: currentPosition!,
                              width: 40,
                              height: 40,
                              child: Transform.rotate(
                                angle: _isMoving
                                    ? _bearing * pi / 180
                                    : 0,
                                child: Icon(
                                  _isMoving
                                      ? Icons.navigation_rounded
                                      : Icons.location_searching_rounded,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // ── Кнопка компаса ─────────────────────────────
                    Positioned(
                      top: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: _alignNorth,
                        child: Transform.rotate(
                          angle: (_mapRotation * pi / 180) - 0.8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(blurRadius: 6, color: Colors.black26),
                              ],
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(
                              CupertinoIcons.compass,
                              size: 50,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ── Кнопка «моё местоположение» ────────────────
                    Positioned(
                      bottom: 140,
                      right: 20,
                      child: GestureDetector(
                        onTap: _centerOnMe,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _autoCenter ? Colors.blue : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(blurRadius: 6, color: Colors.black26),
                            ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.near_me_rounded,
                            size: 40,
                            color: _autoCenter ? Colors.white : Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    
                    // ── Панель шагов ────────────────
                    Positioned(
                      bottom: 140,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          spacing: 8,
                          children: [
                            Text(
                              _isPedometerAvailable ? '$_steps' : '—',
                              style: unbBoldB,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'шагов',
                              style: unbRegW,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ── Панель скорости / направления ──────────────
                    Positioned(
                      bottom: 40,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          spacing: 8,
                          children: [
                            Text(
                              _isMoving
                                  ? _getDirectionLabel(_bearing)
                                  : 'Вы стоите',
                              style: unbRegW,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              _isMoving ? _formatSpeed(_speed) : '0 км/ч',
                              style: unbBoldY,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}