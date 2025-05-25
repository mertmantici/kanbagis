class GetDonation {
  String nameSurname;
  String phone;
  String bloodGroup;
  String age;
  String gender;
  String cityDistrict;
  String hospitalName;
  String description;
  String createDate;
  String groupName;

  GetDonation(
      {required this.nameSurname,
      required this.phone,
      required this.bloodGroup,
      required this.age,
      required this.gender,
      required this.cityDistrict,
      required this.hospitalName,
      required this.description,
      required this.createDate,
      required this.groupName});

  factory GetDonation.fromJson(Map<String, dynamic> json) {
    return GetDonation(
        nameSurname: json["nameSurname"] as String,
        phone: json["phone"] as String,
        bloodGroup: json["bloodGroup"] as String,
        age: json["age"] as String,
        gender: json["gender"] as String,
        cityDistrict: json["cityDistrict"] as String,
        hospitalName: json["hospitalName"] as String,
        description: json["description"] as String,
        createDate: json["createDate"] as String,
        groupName: json["groupName"] as String);
  }
}
