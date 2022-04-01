class Note{
  final String text;

  const Note({
    required this.text,
  });

  Note copyWith({
    String? text,
  }) {
    return Note(
      text: text ?? this.text,
    );
  }
}