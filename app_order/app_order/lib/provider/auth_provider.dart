import 'dart:typed_data';

import 'package:app_order/models.dart/order.dart';
import 'package:app_order/models.dart/post.dart';
import 'package:app_order/models.dart/user_app.dart';
import 'package:app_order/service/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AuthencationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _db;
  late UserApp user;
  String image =
      "https://firebasestorage.googleapis.com/v0/b/app-order-77d19.appspot.com/o/default%2Favatar.jpg?alt=media&token=435f1d44-dc70-436d-a032-99d4e85349c3";
  AuthencationProvider() {
    _auth = FirebaseAuth.instance;
    _db = FirebaseFirestore.instance;

    _auth.authStateChanges().listen((_user) async {
      if (_user != null) {
        DocumentSnapshot snapshot =
            await _db.collection('users').doc(_auth.currentUser!.uid).get();
        user = UserApp.formJson(snapshot.data() as Map<String, dynamic>);
      }
    });
  }

  Future<String> signUpUser(
      {required String email,
      required String pass,
      required String name,
      required String numberPhone}) async {
    String res = "some error";
    try {
      if (email.isNotEmpty || pass.isNotEmpty || name.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: pass);
        UserApp user = UserApp(
          id: cred.user!.uid,
          email: email,
          image: image,
          name: name,
          numberPhone: numberPhone,
        );
        _db.collection('users').doc(cred.user!.uid).set(user.toJson());
        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = 'The email is invalid';
      } else if (e.code == 'weak-password') {
        res = 'Password qua ngan';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "some error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> forgotPassword({required String email}) async {
    String res = "some error";
    try {
      if (email.isNotEmpty) {
        _auth.sendPasswordResetEmail(email: email);
        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // post product

  Future<String> post({
    required String email,
    required String id,
    required Uint8List file,
    required String bio,
    required String type,
    required String price,
    required List color,
    required String name,
    required List size,
  }) async {
    String res = "some error";
    try {
      TypeProduct _typeProduct;
      switch (type) {
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
      String postId = const Uuid().v1();
      String image = await StorageService()
          .uploadImageToStorage(name: "post", file: file, id: id);
      Post post = Post(
        idPost: postId,
        id: id,
        bio: bio,
        image: image,
        price: price,
        sentTime: DateTime.now(),
        type: _typeProduct,
        color: color,
        name: name,
        sellId: [],
        size: size,
      );
      _db.collection(type).doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<UserApp> getUser(String id) async {
    DocumentSnapshot snapshot = await _db.collection('users').doc(id).get();

    UserApp user = UserApp.formJson(snapshot as Map<String, dynamic>);
    return user;
  }

  //get Products
  Future<List<Post>> getPost(String collection) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection(collection).get();
    List<Post> product = [];
    if (snapshot.docs.isNotEmpty) {
      for (var e in snapshot.docs) {
        Map<String, dynamic> _data = e.data();
        Post post = Post.fromJson(_data);
        product.add(post);
      }
    }
    return product;
  }

  Future<List<Post>> getPostUser(String collection) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection(collection).where('id', isEqualTo: user.id).get();
    List<Post> product = [];
    if (snapshot.docs.isNotEmpty) {
      for (var e in snapshot.docs) {
        Map<String, dynamic> _data = e.data();
        Post post = Post.fromJson(_data);
        product.add(post);
      }
    }
    return product;
  }

  Future<List<Post>> getAllPostUser() async {
    List<Post> products = [];
    try {
      List<Post> product = await getPostUser('shoes');
      if (product.isNotEmpty) {
        for (var e in product) {
          products.add(e);
        }
      }
      List<Post> product1 = await getPostUser('shirt');
      if (product1.isNotEmpty) {
        for (var e in product1) {
          products.add(e);
        }
      }
      List<Post> product2 = await getPostUser('pants');
      if (product2.isNotEmpty) {
        for (var e in product2) {
          products.add(e);
        }
      }
      List<Post> product3 = await getPostUser('glasses');
      if (product3.isNotEmpty) {
        for (var e in product3) {
          products.add(e);
        }
      }
      List<Post> product4 = await getPostUser('technological');
      if (product4.isNotEmpty) {
        for (var e in product4) {
          products.add(e);
        }
      }
      List<Post> product5 = await getPostUser('foods');
      if (product5.isNotEmpty) {
        for (var e in product5) {
          products.add(e);
        }
      }
      List<Post> product6 = await getPostUser('book');
      if (product6.isNotEmpty) {
        for (var e in product6) {
          products.add(e);
        }
      }
      List<Post> product7 = await getPostUser('unknown');
      if (product7.isNotEmpty) {
        for (var e in product7) {
          products.add(e);
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return products;
  }

  Future<List<Post>> getAllPost() async {
    List<Post> products = [];
    try {
      List<Post> product = await getPost('shoes');
      if (product.isNotEmpty) {
        for (var e in product) {
          products.add(e);
        }
      }
      List<Post> product1 = await getPost('shirt');
      if (product1.isNotEmpty) {
        for (var e in product1) {
          products.add(e);
        }
      }
      List<Post> product2 = await getPost('pants');
      if (product2.isNotEmpty) {
        for (var e in product2) {
          products.add(e);
        }
      }
      List<Post> product3 = await getPost('glasses');
      if (product3.isNotEmpty) {
        for (var e in product3) {
          products.add(e);
        }
      }
      List<Post> product4 = await getPost('technological');
      if (product4.isNotEmpty) {
        for (var e in product4) {
          products.add(e);
        }
      }
      List<Post> product5 = await getPost('foods');
      if (product5.isNotEmpty) {
        for (var e in product5) {
          products.add(e);
        }
      }
      List<Post> product6 = await getPost('book');
      if (product6.isNotEmpty) {
        for (var e in product6) {
          products.add(e);
        }
      }
      List<Post> product7 = await getPost('unknown');
      if (product7.isNotEmpty) {
        for (var e in product7) {
          products.add(e);
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return products;
  }

  // dat hang

  Future<String> order({
    required String uid,
    required String idOwner,
    required int price,
    required String color,
    required String size,
    required String numberPhone,
    required String address,
    required String productId,
    required String nameProduct,
    required TypeProduct typeProduct,
  }) async {
    String res = 'some error';

    try {
      String idNofi = const Uuid().v1();
      Order oder = Order(
        uid: uid,
        idOwner: idOwner,
        price: price,
        color: color,
        size: size,
        address: address,
        productId: productId,
        nameId: nameProduct,
        sentTime: DateTime.now(),
        idNofi: idNofi,
        numberPhone: numberPhone,
      );

      _db
          .collection('users')
          .doc(idOwner)
          .collection('notification')
          .doc(idNofi)
          .set(
            oder.toJson(),
          );
      _db.collection('users').doc(uid).collection('buy').doc(idNofi).set(
            oder.toJson(),
          );
      String type = typeProduct.name;

      await _db.collection(type).doc(productId).update({
        'sellId': FieldValue.arrayUnion([idNofi]),
      });

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
