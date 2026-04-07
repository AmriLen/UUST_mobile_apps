import 'package:flutter/material.dart';

const unbReg = TextStyle(fontFamily: 'Unbounded', fontSize: 16);
const unbRegW = TextStyle(fontFamily: 'Unbounded', fontSize: 16, color: Colors.white);
const unbRegMin = TextStyle(fontFamily: 'Unbounded', fontSize: 12);
const unbRegWMin = TextStyle(fontFamily: 'Unbounded', fontSize: 12, color: Colors.white);
const unbBold = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 16);
const unbBoldW = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white);
final unbBoldY = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.yellow[700]);
final unbBoldB = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue[400]);
const unbRegDrawer = TextStyle(fontFamily: 'Unbounded', fontSize: 16);
const unbBoldError = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red);


Widget customErrorWidget(String message) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.warning, size: 48, color: Colors.red,),
      SizedBox(height: 8),
      Text(message, style: unbBoldError, textAlign: TextAlign.center,),
      SizedBox(height: 18),
      Text("Перезапустите экран через боковое меню!", style: unbRegMin, textAlign: TextAlign.center,),
    ],
  )
);

Widget customLoadingWidget(String message) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
      SizedBox(height: 32),
      Text(message, style: unbReg, textAlign: TextAlign.center,),
    ],
  )
);