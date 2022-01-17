class Order {
  final String uid;
  final String idOwner;
  final int price;
  final String color;
  final String size;
  final String address;
  final String productId;
  final String nameId;
  final DateTime sentTime;
  final String idNofi;
  final String numberPhone;
  Order({
    required this.uid,
    required this.idOwner,
    required this.price,
    required this.color,
    required this.size,
    required this.address,
    required this.productId,
    required this.nameId,
    required this.sentTime,
    required this.idNofi,
    required this.numberPhone,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'idOwner': idOwner,
      'price': price,
      'color': color,
      'size': size,
      'address': address,
      'productId': productId,
      'nameId': nameId,
      'sentTime': sentTime,
      'idNofi': idNofi,
      'numberPhone': numberPhone,
    };
  }
}
