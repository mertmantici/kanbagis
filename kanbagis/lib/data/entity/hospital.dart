class Hospital {
  final String id;
  final String name;

  Hospital({required this.id, required this.name});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'],
      name: json['name'],
    );
  }
}
