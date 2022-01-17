import 'package:app_order/models.dart/districts.dart';

class Town {
  String? name;
  List<Districts>? districts;

  Town({
    this.name,
    this.districts,
  });

  Town.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(Districts.fromJson(v));
      });
    }
  }
}
