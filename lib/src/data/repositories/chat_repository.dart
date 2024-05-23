import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  final _firestore = FirebaseFirestore.instance;

  // Stream<List<ChatModel>> get chatStream(String userId) {
  //   final userRef = _firestore.collection('users').doc(userId);
  //   return _firestore.collection('chats')
  //       .where('renter', isEqualTo: userRef)
  //       .limit(1)
  //       .snapshots().map((snapshot) {
  //         if (snapshot.)
  //   });
  // }
}