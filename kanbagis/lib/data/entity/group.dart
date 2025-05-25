class Group {
  String? id;
  String name;
  String supervisorId;

  Group({
    this.id,
    required this.name,
    required this.supervisorId,
  });

  factory Group.fromJson(Map<dynamic, dynamic> json) {
    return Group(
        id: json["groupId"] as String,
        name: json["name"] as String,
        supervisorId: json["supervisorId"] as String);
  }
}
