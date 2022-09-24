import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:together/models/userModel.dart';

class Firestore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future addUser({required UserModel user}) async {
    CollectionReference ref = firestore.collection("users");

    var h = await ref
        .doc(auth.currentUser!.uid)
        .set(user.toJson())
        .onError((error, stackTrace) => error)
        .then((value) => null);

    if (h is String) {
      return h;
    }
  }

  Future addEntry({required UserModel user}) async {
    CollectionReference ref = firestore.collection("users");

    var h = await ref
        .doc(auth.currentUser!.uid)
        .set(user.toJson(), SetOptions(merge: true))
        .onError((error, stackTrace) => error)
        .then((value) => null);

    if (h is String) {
      return h;
    }
  }
}
