class NoteEntity {
  final String? userId;
  final String title;
  final String desciprion;
  final String? imagePath;
  final DateTime? createdAt;

  NoteEntity({
    this.userId,
    required this.title,
    required this.desciprion,
    this.imagePath,
    this.createdAt,
  });
}
