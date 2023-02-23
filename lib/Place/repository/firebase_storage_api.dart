import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class FirebaseStorageAPI{
  final Reference reference = FirebaseStorage.instance.ref();

  UploadTask uploadFile (String path, File file){
    return reference.child(path).putFile(file);
  }
}