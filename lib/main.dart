import 'package:flutter/material.dart';

import 'package:uust_mobile_apps/LabScreens/Lab1_Screen/Lab1_Screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UUST Mobile Apps',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Lab1(),
      debugShowCheckedModeBanner: true, //?-Ярлычок Дебага
    );
  }
}
