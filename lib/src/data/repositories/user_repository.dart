import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mepartments/src/data/models/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return UserModel.fromDocumentData(doc.id, doc.data()!);
  }

  DocumentReference getUserReference(String uuid) => _firestore.doc('/users/$uuid');

  Stream<UserModel> userStream(String uid) =>
      _firestore.collection('users').doc(uid).snapshots().map((doc) => UserModel.fromDocumentData(doc.id, doc.data()!));

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {}
}
