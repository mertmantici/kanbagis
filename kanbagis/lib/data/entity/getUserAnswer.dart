class GetUserAnswer {
  String firstName;
  String lastName;
  String bloodGroup;
  String gender;
  String age;
  String city;
  String district;
  String email;
  String phone;

  GetUserAnswer(
      {required this.firstName,
      required this.lastName,
      required this.bloodGroup,
      required this.gender,
      required this.age,
      required this.city,
      required this.district,
      required this.email,
      required this.phone});

  factory GetUserAnswer.fromJson(Map<String, dynamic> json) {
    return GetUserAnswer(
        firstName: json["firstName"] as String,
        lastName: json["lastName"] as String,
        bloodGroup: json["bloodGroup"] as String,
        gender: json["gender"] as String,
        age: json["age"] as String,
        city: json["city"] as String,
        district: json["district"] as String,
        email: json["email"] as String,
        phone: json["phone"] as String);
  }
}
