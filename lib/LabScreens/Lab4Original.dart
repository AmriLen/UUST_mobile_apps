import 'dart:async';

import 'package:flutter/material.dart';

import 'package:uust_mobile_apps/drawer.dart';
import 'package:uust_mobile_apps/constants.dart';


class Lab4 extends StatefulWidget {
  const Lab4({Key? key}) : super(key: key);

  @override
  State<Lab4> createState() => _Lab4State();
}

class _Lab4State extends State<Lab4> {
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
      appBar: AppBar(title: Text('ЛР4: ИИ распознавание', style: unbReg)),
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