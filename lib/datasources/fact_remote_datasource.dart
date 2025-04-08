import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repository/models/facts_model.dart';

class FactRemoteDatasource {
  final String _baseUrl = "https://meowfacts.herokuapp.com/?count=3";

  Future<List<FactsModel>> getFact() async {
    final url = Uri.parse(_baseUrl);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
        "Factlarni yuklashda xatolik bor: ${response.statusCode}",
      );
    }

    final decodedData = jsonDecode(response.body);
    List factsList = decodedData['data'];

    List<FactsModel> allFacts = [];

    for (var fact in factsList) {
      allFacts.add(FactsModel(dates: fact));
    }
    return allFacts;
  }
}
