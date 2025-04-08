import 'package:repository/datasources/fact_local_datasource.dart';
import 'package:repository/datasources/fact_remote_datasource.dart';
import 'package:repository/models/facts_model.dart';

class FactRepository {
  final factLocalDatasource = FactLocalDatasource();
  final factRemoteDatasource = FactRemoteDatasource();

  Future<List<FactsModel>> getFacts() async {
    final localData = await factLocalDatasource.getLogalFact();

    if (localData == null) {
      final remoteData = await factRemoteDatasource.getFact();
      await factLocalDatasource.saveFacts(remoteData);
      return remoteData;
    }
    return localData;
  }
}
