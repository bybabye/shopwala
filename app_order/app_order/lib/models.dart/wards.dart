class Wards {
  String? name;

  Wards({this.name});
  Wards.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
