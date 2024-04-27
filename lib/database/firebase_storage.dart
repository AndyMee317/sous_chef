
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
class FirebaseStorageDatabase{
  Future<String> uploadImage(String childName, Uint8List file)async{
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    await snapshot.ref.getDownloadURL();
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

}