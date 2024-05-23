import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';
import 'package:mepartments/src/data/models/user.dart';

class UserController extends GetxController {
  final Rx<UserModel?> _user = Rx<UserModel?>(null);

  UserModel? get user => _user.value;

  final _auth = auth.FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  DocumentReference? get currentUserReference =>
      user == null ? null : _firestore.collection('users').doc(user!.uuid);

  StreamSubscription<UserModel>? _userSubscription;

  _registerUserListener(String uuid) {
    _userSubscription = _firestore
        .collection('users')
        .doc(uuid)
        .snapshots()
        .map((doc) => UserModel.fromDocumentData(doc.id, doc.data()!))
        .listen((user) {
      _user.value = user;
    });
  }

  @override
  void onClose() {
    _userSubscription?.cancel();
    super.onClose();
  }

  void setUser(UserModel user) {
    _user.value = user;
    _registerUserListener(user.uuid);
  }

  void logout() {
    _auth.signOut();
    _user.value = null;
    _userSubscription?.cancel();
    _userSubscription = null;
  }
}
