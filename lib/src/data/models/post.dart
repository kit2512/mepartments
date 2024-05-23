import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String uuid;
  final Timestamp createdAt;
  final List<String> images;
  final DocumentReference createdBy;
  final List<DocumentReference> reactedBy;

  final String description;

  const PostModel({
    required this.uuid,
    required this.createdAt,
    required this.images,
    required this.createdBy,
    required this.reactedBy,
    required this.description,
  });

  factory PostModel.fromData(Map<String, dynamic> data) {
    return PostModel(
      uuid: data['uuid'],
      createdAt: data['createdAt'],
      images: (data['images'] as List).map((e) => e.toString()).toList(),
      createdBy: data['createdBy'],
      reactedBy: (data['reactedBy'] as List).map((e) => e as DocumentReference).toList(),
      description: data['description'],
    );
  }
}
