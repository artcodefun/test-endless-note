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

  Map<String, dynamic> toMap() {
    return {
      'text': this.text,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      text: map['text'] as String,
    );
  }
}