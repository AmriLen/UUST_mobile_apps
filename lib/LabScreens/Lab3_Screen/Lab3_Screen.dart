import 'package:flutter/material.dart';

import 'package:uust_mobile_apps/drawer.dart';
import 'package:uust_mobile_apps/constants.dart';
import 'package:uust_mobile_apps/LabScreens/Lab3_Screen/drug.dart';
import 'package:uust_mobile_apps/LabScreens/Lab3_Screen/mock_data.dart';
import 'package:uust_mobile_apps/LabScreens/Lab3_Screen/drug_detail.dart';
import 'package:uust_mobile_apps/LabScreens/Lab3_Screen/search_delegate.dart';


class Lab3 extends StatefulWidget {
  const Lab3({Key? key}) : super(key: key);

  @override
  State<Lab3> createState() => _Lab3State();
}

class _Lab3State extends State<Lab3> {
  bool isLoading = true;
  String loadingMessage = "Загружаем лекарства...";
  String? errorMessage;

  List<Drug> drugList = [];
  String _selectedCategory = 'Все';

  List<String> get _categories {
    final cats = drugList.map((d) => d.category).toSet().toList()..sort();
    return ['Все', ...cats];
  }

  List<Drug> get _filteredDrugs {
    if (_selectedCategory == 'Все') return drugList;
    return drugList.where((d) => d.category == _selectedCategory).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      setState(() {
        drugList = drugs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Ошибка загрузки!";
        isLoading = false;
      });
    }
  }

  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 52,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = cat == _selectedCategory;
              final color =
                  cat == 'Все' ? Colors.blueGrey : getCategoryColor(cat);
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(
                    cat,
                    style: TextStyle(
                      fontFamily: 'Unbounded',
                      fontSize: 11,
                      color: isSelected ? Colors.white : color,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) =>
                      setState(() => _selectedCategory = cat),
                  backgroundColor: color.withValues(alpha: 0.08),
                  selectedColor: color,
                  checkmarkColor: Colors.white,
                  showCheckmark: false,
                  side: BorderSide(color: color, width: 1.5),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 6),
          child: Text(
            'Найдено: ${_filteredDrugs.length}',
            style: unbRegMin.copyWith(color: Colors.black45),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(Drug drug) {
    final catColor = getCategoryColor(drug.category);
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DrugDetail(drug: drug)),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(16)),
                child: Image.network(
                  drug.image,
                  width: 100,
                  height: 110,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 120,
                      height: 110,
                      color: catColor.withValues(alpha: 0.12),
                      child: Icon(Icons.medication,
                          size: 48, color: catColor.withValues(alpha: 0.6)),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(drug.name, style: unbReg),
                      const SizedBox(height: 4),
                      Text(
                        drug.description,
                        style: unbRegMin,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: catColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: catColor.withValues(alpha: 0.4), width: 1),
                            ),
                            child: Text(
                              drug.category,
                              style: TextStyle(
                                fontFamily: 'Unbounded',
                                fontSize: 10,
                                color: catColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            drug.dosage,
                            style: unbRegMin.copyWith(
                                color: Colors.black45, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black38),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Медицинский справочник', style: unbReg),
      ),
      body: errorMessage != null
          ? customErrorWidget(errorMessage!)
          : isLoading
              ? customLoadingWidget(loadingMessage)
              : Column(
                  children: [
                    _buildCategoryFilter(),
                    Expanded(
                      child: _filteredDrugs.isEmpty
                          ? Center(
                              child: Text(
                                'Нет лекарств в категории\n"$_selectedCategory"',
                                style: unbBoldTransp,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                              itemCount: _filteredDrugs.length,
                              itemBuilder: (context, index) =>
                                  _buildCard(_filteredDrugs[index]),
                            ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () async {
          final result = await showSearch(
            context: context,
            delegate: DrugSearchDelegate(drugList),
          );
          if (result != null) {
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DrugDetail(drug: result)),
            );
          }
        },
      ),
    );
  }
}
