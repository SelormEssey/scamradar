import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> uploadReport({
  required String phone,
  required String username,
  required String scamType,
  required String description,
  required File? image,
}) async {
  String? imageUrl;

  if (image != null) {
    final ref = FirebaseStorage.instance
        .ref()
        .child('evidence')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(image);
    imageUrl = await ref.getDownloadURL();
  }

  await FirebaseFirestore.instance.collection('reports').add({
    'phoneNumber': phone,
    'usernameOrPage': username,
    'scamType': scamType,
    'description': description,
    'evidenceURL': imageUrl ?? '',
    'timestamp': FieldValue.serverTimestamp(),
  });
}
