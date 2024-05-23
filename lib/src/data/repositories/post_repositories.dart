import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mepartments/src/data/models/attachment.dart';
import 'package:mepartments/src/data/models/post.dart';

class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<PostModel>> get postStream {
    return _firestore.collection('post').snapshots().map((snapshot) {
      return snapshot.docs.map(
        (doc) {
          return PostModel.fromData(
            {
              'uuid': doc.id,
              ...doc.data(),
            },
          );
        },
      ).toList();
    });
  }

  Stream<List<AttachmentModel>> attachmentsStream(String postId) {
    return _firestore.collection('post').doc(postId).collection('attachments').snapshots().map((snapshot) {
      return snapshot.docs.map(
        (doc) {
          return AttachmentModel.fromData(
            doc.id,
            doc.data(),
          );
        },
      ).toList();
    });
  }
//
// Future<void> createPost(PostModel post) async {
//   await _firestore.collection('posts').add(post.toJson());
// }
//
// Future<void> updatePost(PostModel post) async {
//   await _firestore.collection('posts').doc(post.uuid).update(post.toJson());
// }
//
// Future<void> deletePost(String uuid) async {
//   await _firestore.collection('posts').doc(uuid).delete();
// }
//
// Future<void> reactToPost(String uuid, String userId) async {
//   await _firestore.collection('posts').doc(uuid).update(
//     {
//       'reactedBy': FieldValue.arrayUnion(['/users/$userId']),
//     },
//   );
// }
//
// Future<void> unreactToPost(String uuid, String userId) async {
//   await _firestore.collection('posts').doc(uuid).update(
//     {
//       'reactedBy': FieldValue.arrayRemove(['/users/$userId']),
//     },
//   );
// }
//
// Future<void> addAttachmentToPost(String uuid, String attachmentId) async {
//   await _firestore.collection('posts').doc(uuid).update(
//     {
//       'attachments': FieldValue.arrayUnion(['/attachments/$attachmentId']),
//     },
//   );
// }
}
