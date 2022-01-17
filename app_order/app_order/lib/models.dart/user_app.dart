class UserApp {
  final String id;
  final String name;
  final String image;
  final String email;
  final String numberPhone;

  UserApp({
    required this.id,
    required this.email,
    required this.image,
    required this.name,
    required this.numberPhone,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        "name": name,
        'image': image,
        'email': email,
        'numberPhone': numberPhone,
      };

  factory UserApp.formJson(Map<String, dynamic> json) {
    return UserApp(
      id: json['id'],
      email: json['email'],
      image: json['image'],
      name: json['name'],
      numberPhone: json['numberPhone'],
    );
  }
}
