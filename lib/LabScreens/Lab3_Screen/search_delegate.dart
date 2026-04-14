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
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = drugs.where((d) => 
      d.name.toLowerCase().contains(query.toLowerCase()) || 
      d.description.toLowerCase().contains(query.toLowerCase())
    ).toList();

    return buildList(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = drugs.where((d) => 
    d.name.toLowerCase().contains(query.toLowerCase()) || 
    d.description.toLowerCase().contains(query.toLowerCase())
  ).toList();

    return buildList(context, results);
  }

  Widget buildList(BuildContext context, List<Drug> list) {
    if (list.isEmpty) {
      return Center(
        child: Text("Ничего не найдено!", style: unbBoldTransp,),
        );
    }

    return ListView(
      children: list.map((drug) {
        return ListTile(
          title: Text(drug.name, style: unbReg),
          subtitle: Text(drug.description, style: unbRegMin),
          onTap: () {
            close(context, drug);
          },
        );
      }).toList(),
    );
  }  
}