class TodoModal {
  int? id;
  String? title;
  String? description;

  TodoModal({
    this.id,
    this.title,
    this.description,
  });

  factory TodoModal.fromJson(Map<String, dynamic> json) => TodoModal(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
