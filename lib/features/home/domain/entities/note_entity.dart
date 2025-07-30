class NoteEntity {
  final String? id;
  final String? userId;
  final String title;
  final String description;
  final String imagePath;
  final String? createdAt;

  NoteEntity({
    this.id,
    this.userId,
    required this.title,
    required this.description,
    required this.imagePath,
    this.createdAt,
  });
}
