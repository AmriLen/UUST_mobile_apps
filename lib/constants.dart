import 'package:flutter/material.dart';

const versionApp = '0.3.16';

const unbRegBig = TextStyle(fontFamily: 'Unbounded', fontSize: 20);
const unbReg = TextStyle(fontFamily: 'Unbounded', fontSize: 16);
const unbRegW = TextStyle(fontFamily: 'Unbounded', fontSize: 16, color: Colors.white);
const unbRegR = TextStyle(fontFamily: 'Unbounded', fontSize: 16, color: Colors.red);
const unbRegMin = TextStyle(fontFamily: 'Unbounded', fontSize: 12);
const unbRegWMin = TextStyle(fontFamily: 'Unbounded', fontSize: 12, color: Colors.white);

const unbBoldBig = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 22);
const unbBold = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 16);
const unbBoldTransp = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 16, color:Colors.black38);
const unbBoldW = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white);
final unbBoldY = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.yellow[700]);
final unbBoldB = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue[400]);

const unbRegDrawer = TextStyle(fontFamily: 'Unbounded', fontSize: 16);
const unbBoldError = TextStyle(fontFamily: 'Unbounded', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red);


const Map<String, Color> categoryColors = {
  'Обезбол.':       Color(0xFFE65100),
  'Противовирусные':      Color(0xFF0D47A1),
  'Муколитики':           Color(0xFF00695C),
  'Витамины':             Color(0xFF2E7D32),
  'Дерматология':         Color(0xFFAD1457),
  'Антибиотики':          Color(0xFFC62828),
  'Антиаллергические':    Color(0xFF6A1B9A),
  'ЖКТ':                  Color(0xFF4E342E),
  'Серд.-сос.':  Color(0xFF880E4F),
};

Color getCategoryColor(String category) =>
    categoryColors[category] ?? Colors.grey;

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