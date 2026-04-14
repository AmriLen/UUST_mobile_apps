import 'package:flutter/material.dart';

import 'package:uust_mobile_apps/drawer.dart';
import 'package:uust_mobile_apps/constants.dart';
import 'package:uust_mobile_apps/LabScreens/Lab3_Screen/drug.dart';
import 'package:uust_mobile_apps/LabScreens/Lab3_Screen/mock_data.dart';
import 'package:uust_mobile_apps/LabScreens/Lab3_Screen/drug_detail.dart';
import 'package:uust_mobile_apps/LabScreens/Lab3_Screen/search_delegate.dart';


class Lab3 extends StatefulWidget {
  const Lab3({Key? key}) : super(key: key);

  @override
  State<Lab3> createState() => _Lab3State();
}

class _Lab3State extends State<Lab3> {
  bool isLoading = true;
  String loadingMessage = "Загружаем лекарства...";
  String? errorMessage;

  List<Drug> drugList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadData() async {
    await Future.delayed(Duration(seconds: 1));

    try {
      setState(() {
        drugList = drugs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Ошибка загрузки!";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: Text('ЛР3: Медицинский справочник', style: unbReg,)),
      body: errorMessage != null
          ? customErrorWidget(errorMessage!)
          : isLoading == true
          ? customLoadingWidget(loadingMessage)
          : ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: drugList.length,
            itemBuilder: (context, index) {
              final drug = drugList[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DrugDetail(drug: drug),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      // Картинка
                      ClipRRect(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
                        child: Image.network(
                          drug.image,
                          width: 120,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image),
                            );
                          },
                        )
                      ),

                      SizedBox(width: 12),

                      // Текст
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                drug.name,
                                style: unbReg,
                              ),
                              SizedBox(height: 6),
                              Text(
                                drug.description,
                                style: unbRegMin,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Icon(Icons.arrow_forward_ios, size: 16),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () async {
          final result = await showSearch(
            context: context,
            delegate: DrugSearchDelegate(drugs),
          );

          if (result != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DrugDetail(drug: result),
              ),
            );
          }
        },
      ),
    );
  }
}