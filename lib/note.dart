// NAME: Ieskandar Zulqarnain Bin Ghazali
// MATRIC NO: A20EC0046
// COURSE: SECJ3623-01(MOBILE APPLICATION PROGRAMMING)

class Note {
  final String id;
  String? title;
  String? content;

  Note({required this.id, this.title, this.content});

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '', // Use empty string as default if 'id' is null
        title = json['title'],
        content = json['content'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
      };
}
