import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mepartments/src/data/enums.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String citizenId;
  final String firstName;
  final String lastName;
  final String email;
  final Timestamp dateOfBirth;
  final Timestamp createdAt;
  final String? fcmToken;
  final UserRole role;
  final String? profileImage;
  final String uuid;
  final bool? gender;

  const UserModel({
    required this.citizenId,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.dateOfBirth,
    required this.createdAt,
    required this.fcmToken,
    required this.role,
    required this.profileImage,
    required this.uuid,
    required this.gender,
  });

  factory UserModel.fromDocumentData(String uuid, Map<String, dynamic> data) => UserModel(
      citizenId: data['citizenId'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      dateOfBirth: data['dateOfBirth'],
      createdAt: data['createdAt'],
      fcmToken: data['fcmToken'],
      role: UserRole.values.byName(data['role']),
      profileImage: data['profileImage'],
      uuid: uuid,
      gender: data['gender']);

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
        citizenId,
        firstName,
        lastName,
        email,
        dateOfBirth,
        createdAt,
        fcmToken,
        role,
        profileImage,
      ];
}
