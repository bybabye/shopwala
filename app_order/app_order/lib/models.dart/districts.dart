import 'package:app_order/models.dart/wards.dart';

class Districts {
  String? name;
  List<Wards>? wards;

  Districts({
    this.name,
    this.wards,
  });

  Districts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    json['name'];
    if (json['wards'] != null) {
      wards = <Wards>[];
      json['wards'].forEach((v) {
        wards!.add(Wards.fromJson(v));
      });
    }
  }
}
