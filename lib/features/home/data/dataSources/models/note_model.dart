import 'package:bingo_firebase_example/core/helper/exteensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String title;
  final String desciprion;
  final String? imagePath;
  final String userId;
  final String createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.desciprion,
    this.imagePath,
    required this.userId,
    required this.createdAt,
  });
  Map<String, dynamic> toMap() => {
    'title': title,
    'description': desciprion,
    'user_id': userId,
    'image_url': imagePath,
    'created_at': createdAt,
  };

  factory NoteModel.fromMap(Map<String, dynamic> map, String docId) {
    return NoteModel(
      id: docId,
      title: map['title'],
      desciprion: map['description'],
      userId: map['user_id'],
      imagePath: map['image_url'],
      createdAt: (map['created_at'] as Timestamp).toDate().format(
        "HH:mm  dd-MM",
      ),
    );
  }
}
