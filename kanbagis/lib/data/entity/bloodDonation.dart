class BloodDonation {
  bool currentUser;
  String? name;
  String? surname;
  String? phoneNumber;
  String? email;
  String? bloodGroup;
  String? age;
  String? gender;
  String description;
  String hospitalId;

  BloodDonation(
      {required this.currentUser,
      this.name,
      this.surname,
      this.phoneNumber,
      this.email,
      this.bloodGroup,
      this.age,
      this.gender,
      required this.description,
      required this.hospitalId});
  factory BloodDonation.fromJson(Map<dynamic, dynamic> json) {
    return BloodDonation(
        currentUser: json["currentUser"] as bool,
        name: json["name"] as String,
        surname: json["surname"] as String,
        phoneNumber: json["phoneNumber"] as String,
        email: json["email"] as String,
        bloodGroup: json["bloodGroup"] as String,
        age: json["age"] as String,
        gender: json["gender"] as String,
        description: json["description"] as String,
        hospitalId: json["hospitalId"] as String);
  }
}
