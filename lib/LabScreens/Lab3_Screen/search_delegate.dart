import 'package:flutter/material.dart';
import 'package:uust_mobile_apps/constants.dart';
import 'drug.dart';

class DrugSearchDelegate extends SearchDelegate<Drug?> {
  final List<Drug> drugs;

  DrugSearchDelegate(this.drugs);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = "",
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  List<Drug> _filter() {
    final q = query.toLowerCase();
    return drugs.where((d) =>
        d.name.toLowerCase().contains(q) ||
        d.description.toLowerCase().contains(q) ||
        d.category.toLowerCase().contains(q) ||
        d.type.toLowerCase().contains(q)).toList();
  }

  @override
  Widget buildResults(BuildContext context) => _buildList(context, _filter());

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context, _filter());

  Widget _buildList(BuildContext context, List<Drug> list) {
    if (list.isEmpty) {
      return Center(child: Text("Ничего не найдено!", style: unbBoldTransp));
    }

    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final drug = list[index];
        final catColor = getCategoryColor(drug.category);
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              drug.image,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 48,
                height: 48,
                color: catColor.withValues(alpha: 0.15),
                child: Icon(Icons.medication, color: catColor, size: 24),
              ),
            ),
          ),
          title: Text(drug.name, style: unbReg),
          subtitle: Text(drug.description, style: unbRegMin, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Chip(
            label: Text(
              drug.category,
              style: const TextStyle(
                  fontFamily: 'Unbounded', fontSize: 10, color: Colors.white),
            ),
            backgroundColor: catColor,
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          onTap: () => close(context, drug),
        );
      },
    );
  }
}
