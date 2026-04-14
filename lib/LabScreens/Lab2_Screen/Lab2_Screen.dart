import 'dart:async';

import 'package:flutter/material.dart';

import 'package:uust_mobile_apps/drawer.dart';
import 'package:uust_mobile_apps/constants.dart';


class Lab2 extends StatefulWidget {
  const Lab2({Key? key}) : super(key: key);

  @override
  State<Lab2> createState() => _Lab2State();
}

class _Lab2State extends State<Lab2> {
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
      appBar: AppBar(title: Text('ЛР2: Camino de Santiago', style: unbReg)),
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