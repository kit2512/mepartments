import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AttachmentModel extends Equatable {
  final String uuid;
  final String url;
  final String name;
  final DocumentReference createdBy;
  final Timestamp createdAt;

  const AttachmentModel(
    this.uuid, {
    required this.url,
    required this.name,
    required this.createdBy,
    required this.createdAt,
  });

  factory AttachmentModel.fromData(String id, Map<String, dynamic> data) {
    final createdBy = data['createdBy'] as DocumentReference;
    final createdAt = (data['createdAt'] as Timestamp);
    return AttachmentModel(
      id,
      url: data['url'] as String,
      name: data['name'] as String,
      createdBy: createdBy,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [uuid, url, name, createdBy, createdAt];
}
