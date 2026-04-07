import 'dart:async';

import 'package:flutter/material.dart';

import 'package:uust_mobile_apps/drawer.dart';
import 'package:uust_mobile_apps/constants.dart';


class Lab3 extends StatefulWidget {
  const Lab3({Key? key}) : super(key: key);

  @override
  State<Lab3> createState() => _Lab3State();
}

class _Lab3State extends State<Lab3> {
  bool isLoading = true;
  String loadingMessage = "Загружаем данные...";
  String? errorMessage = "Нет данных";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: Text('ЛР3: Медицинский справочник')),
      body: errorMessage != null
          ? customErrorWidget(errorMessage!)
          : isLoading == true
          ? customLoadingWidget(loadingMessage)
          : Stack(
              children: [
                Text("OK!", style: unbRegMin, textAlign: TextAlign.center,),
              ],
            ),
    );
  }
}