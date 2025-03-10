class User {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  String bloodGroup;
  String gender;
  String age;
  String city;
  String district;

  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.bloodGroup,
      required this.gender,
      required this.age,
      required this.city,
      required this.district});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json["firstName"] as String,
        lastName: json["lastName"] as String,
        email: json["email"] as String,
        phoneNumber: json["phoneNumber"] as String,
        password: json["password"] as String,
        bloodGroup: json["bloodGroup"] as String,
        gender: json["gender"] as String,
        age: json["age"] as String,
        city: json["city"] as String,
        district: json["district"] as String);
  }
}
