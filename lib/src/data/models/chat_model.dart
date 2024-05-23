import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mepartments/src/data/enums.dart';
import 'package:rxdart/rxdart.dart';

class ChatModel {
  Timestamp createdAt;
  final String id;
  final DocumentReference? lastMessage;
  final DocumentReference renter;
  final List<MessageModel> messages;

  ChatModel({
    required this.createdAt,
    required this.id,
    required this.lastMessage,
    required this.renter,
    required this.messages,
  });

  factory ChatModel.fromData(String uid, Map<String, dynamic> data) {
    return ChatModel(
      createdAt: data['createdAt'],
      id: data['id'],
      lastMessage: data['lastMessage'],
      renter: data['renter'],
      messages: [],
    );
  }
}

class MessageModel {
  final String id;
  final TimerStream sentAt;
  final UserRole from;
  final bool readByRenter;
  final bool readByManger;
  final String content;

  MessageModel({
    required this.id,
    required this.sentAt,
    required this.from,
    required this.readByRenter,
    required this.readByManger,
    required this.content,
  });

  factory MessageModel.fromData(String uid, Map<String, dynamic> data) {
    return MessageModel(
      id: data['id'],
      sentAt: data['sentAt'],
      from: data['from'],
      readByRenter: data['readByRenter'],
      readByManger: data['readByManger'],
      content: data['content'],
    );
  }
}
