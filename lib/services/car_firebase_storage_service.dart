import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CarFirebaseStorageService {
  final _carsImageStorage = FirebaseStorage.instance;
  final _carCollection = FirebaseFirestore.instance.collection('car');

  Future<void> addCarImage(String name, File imageFile) async {
    final imageReferance =
        _carsImageStorage.ref().child("cars/images/$name.jpg");
    final uploadTask = imageReferance.putFile(imageFile);

    await uploadTask.whenComplete(() async {
      final imageUrl = await imageReferance.getDownloadURL();
      await _carCollection.add({"name": name, "imageUrl": imageUrl});
    });
  }
}
