import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:trips/Place/repository/firebase_storage_api.dart';

class FirebaseStorageRepository {

  final _firebaseStorageAPI = FirebaseStorageAPI();
  UploadTask uploadFile(String path, File file) => _firebaseStorageAPI.uploadFile(path, file);
}