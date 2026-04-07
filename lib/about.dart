import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:uust_mobile_apps/drawer.dart';
import 'package:uust_mobile_apps/constants.dart';


class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: Text('О приложении')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Приложение разработано \nв процессе прохождения предмета:", style: unbReg),
            SizedBox(height: 10),
            Text("Разработка мобильных приложений", style: unbBold),
            SizedBox(height: 100),
            Text("Студентами группы ПРО-206Б", style: unbReg,),
            SizedBox(height: 20),
            Text("Айчуваков Амир Маратович", style: unbReg,),
            Text("Волков Иван Сергеевич", style: unbReg,),
            Text("Думчев Иван Николаевич", style: unbReg,),
            SizedBox(height: 20),
            Text("Версия: ", style: unbReg,),
            //Text($version, style: unbReg,),
          ],
        )
      ),
    );
  }
}