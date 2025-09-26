class Healthtip {
  int id;
  String title;
  String content;

  Healthtip({required this.id, required this.title, required this.content});
  // ---------------- UML Methods ----------------

  String getTip() {
    return "💡 $title: $content";
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'content': content};
  }

  factory Healthtip.fromJson(Map<String, dynamic> json) {
    return Healthtip(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }
}
