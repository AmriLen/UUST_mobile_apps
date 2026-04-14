import 'package:flutter/material.dart';
import 'drug.dart';

import 'package:uust_mobile_apps/constants.dart';

class DrugDetail extends StatelessWidget {
  final Drug drug;

  const DrugDetail({Key? key, required this.drug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(drug.name, style: unbRegBig,),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              drug.image,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image),
                );
              },
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(drug.name, style: unbBoldBig),

                  SizedBox(height: 10),

                  Text("Тип: ${drug.type}", style: unbReg),

                  Text('Срок годности: ${drug.date}', style: unbReg),

                  SizedBox(height: 18),

                  Text("Описание", style: unbBold),
                  Text(drug.description, style: unbReg,),

                  Container(
                    height: 2,
                    color: Colors.black26,
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 22),
                  ),

                  Text("Применение", style: unbBold),
                  Text(drug.usage, style: unbRegMin),

                  SizedBox(height: 18),

                  Text("Противопоказания", style: unbBold),
                  Text(drug.unusage, style: unbRegMin,),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}