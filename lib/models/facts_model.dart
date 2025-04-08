// ignore_for_file: public_member_api_docs, sort_constructors_first
class FactsModel {
  final String dates;

  FactsModel({required this.dates});

  factory FactsModel.fromJson(String json) {
    return FactsModel(dates: json);
  }

  Map<String, dynamic> toJson() {
    return {"data": dates};
  }
}
