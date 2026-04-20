import 'package:flutter/material.dart';
import 'drug.dart';

import 'package:uust_mobile_apps/constants.dart';

class DrugDetail extends StatelessWidget {
  final Drug drug;

  const DrugDetail({Key? key, required this.drug}) : super(key: key);

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.black45),
          const SizedBox(width: 8),
          Text("$label: ", style: unbRegMin.copyWith(color: Colors.black45)),
          Expanded(child: Text(value, style: unbRegMin)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final catColor = getCategoryColor(drug.category);

    return Scaffold(
      appBar: AppBar(
        title: Text(drug.name, style: unbRegBig),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              drug.image,
              width: double.infinity,
              height: 260,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 260,
                  color: catColor.withValues(alpha: 0.12),
                  child: Icon(Icons.medication,
                      size: 80, color: catColor.withValues(alpha: 0.5)),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(drug.name, style: unbBoldBig),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      Chip(
                        avatar: Icon(Icons.category,
                            size: 14, color: Colors.white),
                        label: Text(drug.category,
                            style: const TextStyle(
                                fontFamily: 'Unbounded',
                                fontSize: 11,
                                color: Colors.white)),
                        backgroundColor: catColor,
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      Chip(
                        avatar: Icon(Icons.scale,
                            size: 14, color: Colors.black54),
                        label: Text(drug.dosage,
                            style: const TextStyle(
                                fontFamily: 'Unbounded', fontSize: 11)),
                        backgroundColor: Colors.grey[200],
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  _infoRow(Icons.medication_liquid, "Форма выпуска", drug.type),
                  _infoRow(Icons.calendar_today, "Срок годности", drug.date),

                  Container(
                    height: 1.5,
                    color: Colors.black12,
                    margin: const EdgeInsets.symmetric(vertical: 18),
                  ),

                  Text("Описание", style: unbBold),
                  const SizedBox(height: 6),
                  Text(drug.description, style: unbReg),

                  Container(
                    height: 1.5,
                    color: Colors.black12,
                    margin: const EdgeInsets.symmetric(vertical: 18),
                  ),

                  Text("Применение", style: unbBold),
                  const SizedBox(height: 6),
                  Text(drug.usage, style: unbRegMin),

                  const SizedBox(height: 18),

                  Text("Противопоказания", style: unbBold),
                  const SizedBox(height: 6),
                  Text(drug.unusage, style: unbRegMin),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
