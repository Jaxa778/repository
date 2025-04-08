import 'dart:convert';

import 'package:repository/models/facts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactLocalDatasource {
  Future<void> saveFacts(List<FactsModel> saveFacts) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    List<String> jsonFacts =
        saveFacts.map((fact) => jsonEncode(fact.toJson())).toList();

    await sharedPreferences.setStringList("data", jsonFacts);
  }

  Future<List<FactsModel>?> getLogalFact() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final List<String>? jsonList = sharedPreferences.getStringList("data");
    if (jsonList == null) return [];

    final factsList = <FactsModel>[];

    for (var jsonItem in jsonList) {
      final decodedData = jsonDecode(jsonItem);
      factsList.add(FactsModel.fromJson(decodedData["data"]));
    }
    return factsList;
  }
}
