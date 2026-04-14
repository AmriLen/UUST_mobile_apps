import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uust_mobile_apps/about.dart';

import 'package:uust_mobile_apps/constants.dart';
import 'package:uust_mobile_apps/LabScreens/Lab1_Screen/Lab1_Screen.dart';
import 'package:uust_mobile_apps/LabScreens/Lab2_Screen/Lab2_Screen.dart';
import 'package:uust_mobile_apps/LabScreens/Lab3_Screen/Lab3_Screen.dart';
import 'package:uust_mobile_apps/LabScreens/Lab4_Screen/Lab4_Screen.dart';


class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            height: 100,
            child: DrawerHeader(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Text('Mobile PROJECTS', style: unbBold, textAlign: TextAlign.justify),
            ),
          ),

          ListTile(
            leading: Icon(Icons.map, size: 20,),
            title: Text('Лабораторная работа 1', style: unbRegMin),
            subtitle: Text('Геолокация и датчики', style: unbRegMin),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Lab1()),);
            },
          ),

          ListTile(
            leading: Icon(Icons.map, size: 20,),
            title: Text('Лабораторная работа 2', style: unbRegMin),
            subtitle: Text('Camino de Santiago', style: unbRegMin),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Lab2()),);
            },
          ),

          ListTile(
            leading: Icon(Icons.map, size: 20,),
            title: Text('Лабораторная работа 3', style: unbRegMin),
            subtitle: Text('Медицинский справочник', style: unbRegMin),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Lab3()),);
            },
          ),

          ListTile(
            leading: Icon(Icons.map, size: 20,),
            title: Text('Лабораторная работа 4', style: unbRegMin),
            subtitle: Text('ИИ распознавание', style: unbRegMin),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Lab4()),);
            },
          ),

          Container(
            height: 1,
            color: Colors.black26,
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          ),

          ListTile(
            leading: Icon(Icons.info, size: 20,),
            title: Text('О приложении', style: unbReg),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AboutPage()),);
            },
          )
        ]
      ),
    );
  }
}