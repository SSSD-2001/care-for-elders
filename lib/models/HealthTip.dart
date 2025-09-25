class Healthtip {
    int id;
    String title;
    String content;

    Healthtip({
        required this.id,
        required this.title,
        required this.content,
    });

    Map<String, dynamic> toJson() {
      return {
        'id': id,
        'title': title,
        'content': content,
      };
    }

    factory Healthtip.fromJson(Map<String, dynamic> json) {
      return Healthtip(
        id: json['id'],
        title: json['title'],
        content: json['content'],
      );
    }
}