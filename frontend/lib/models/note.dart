class Note {
  final String id;
  final String title;
  final String content;
  final String timestamp;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  // Convert JSON to Note object
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      timestamp: json['timestamp'] as String,
    );
  }

  // Convert Note object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'timestamp': timestamp,
    };
  }

  // Create a copy of the note with updated fields
  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? timestamp,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}