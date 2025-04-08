import 'package:repository/models/facts_model.dart';
import 'package:repository/repository/fact_repository.dart';

class FactViewModel {
  final String baseUrl = "https://meowfacts.herokuapp.com/?count=3";
  final factRepository = FactRepository();
  List<FactsModel> facts = [];

  Future<void> getFacts() async {
    final result = await factRepository.getFacts();

    facts = result;
  }
}
