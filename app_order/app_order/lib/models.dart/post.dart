enum TypeProduct {
  shoes,
  shirt,
  pants,
  glasses,
  technological,
  foods,
  book,
  unknown,
}

class Post {
  final String idPost;
  final String id;
  final String image;
  final String price;
  final DateTime sentTime;
  final String bio;
  final TypeProduct type;
  final String name;
  final List size;
  final List color;
  final List sellId;
  Post({
    required this.idPost,
    required this.id,
    required this.bio,
    required this.image,
    required this.price,
    required this.sentTime,
    required this.type,
    required this.color,
    required this.name,
    required this.sellId,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    String _typeProduct;
    switch (type) {
      case TypeProduct.shirt:
        _typeProduct = "shirt";
        break;
      case TypeProduct.shoes:
        _typeProduct = 'shoes';
        break;
      case TypeProduct.pants:
        _typeProduct = 'pants';
        break;
      case TypeProduct.glasses:
        _typeProduct = 'glasses';
        break;
      case TypeProduct.technological:
        _typeProduct = "technological";
        break;
      case TypeProduct.foods:
        _typeProduct = "foods";
        break;
      case TypeProduct.book:
        _typeProduct = "book";
        break;
      default:
        _typeProduct = 'unknown';
    }
    return {
      'idPost': idPost,
      'id': id,
      'image': image,
      'price': price,
      'sentTime': sentTime,
      'bio': bio,
      'type': _typeProduct,
      'color': color,
      'size': size,
      'sellId': sellId,
      'name': name,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    TypeProduct _typeProduct;
    switch (json['type']) {
      case "shirt":
        _typeProduct = TypeProduct.shirt;
        break;
      case 'shoes':
        _typeProduct = TypeProduct.shoes;
        break;
      case 'pants':
        _typeProduct = TypeProduct.pants;
        break;
      case 'glasses':
        _typeProduct = TypeProduct.glasses;
        break;
      case "technological":
        _typeProduct = TypeProduct.technological;
        break;
      case "foods":
        _typeProduct = TypeProduct.foods;
        break;
      case "book":
        _typeProduct = TypeProduct.book;
        break;
      default:
        _typeProduct = TypeProduct.unknown;
    }
    return Post(
      idPost: json['idPost'],
      id: json['id'],
      bio: json['bio'],
      image: json['image'],
      price: json['price'],
      sentTime: json['sentTime'].toDate(),
      type: _typeProduct,
      color: json['color'],
      name: json['name'],
      sellId: json['sellId'],
      size: json['size'],
    );
  }
}
