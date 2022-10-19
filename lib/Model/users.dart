class Users {
  final String title;
  final String note;

  Users({
    required this.title,
    required this.note,
  });

  Users.fromMap(Map<String, dynamic> result):
      title = result["title"],
        note = result["note"];
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'note': note,
    };
  }
}
