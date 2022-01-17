import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(
      {required String name,
      required Uint8List file,
      required String id}) async {
    String idPost = const Uuid().v1();
    Reference ref = _storage.ref().child(name).child(id).child(idPost);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    String dowloadURL = await snap.ref.getDownloadURL();

    return dowloadURL;
  }
}
