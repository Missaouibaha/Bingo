import 'package:bingo_firebase_example/features/home/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel(
   { super.userId,
   required super.title,
   required super.desciprion,
    super.imagePath,
    super.createdAt,
   }
  );
  Map<String, dynamic> toMap() => {
    'title': title,
    'description': desciprion,
    'userId': userId,
    'imagePath': imagePath,
    'createdAt': createdAt,
  };

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'],
      desciprion: map['description'],
      userId: map['userId'],
      imagePath: map['imagePath'],
      createdAt: map['createdAt'],
    );
  }
}
