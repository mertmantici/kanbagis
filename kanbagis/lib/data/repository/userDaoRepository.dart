import 'package:dio/dio.dart';

class UserDaoRepository {
  Future<void> kisiKayit(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      String bloodGroup,
      String gender,
      String age,
      String city,
      String district) async {
    var url = "https://10.0.2.2:8000/api/Auth/CreateUser";
    var veri = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "bloodGroup": bloodGroup,
      "gender": gender,
      "age": age,
      "city": city,
      "district": district
    };
    print("Gönderilen veri : $veri");
    try {
      var cevap = await Dio().post(url,
          data: veri,
          options: Options(
            headers: {
              "Content-Type": "application/json",
            },
          ));
      print("Kayıt başarılı : ${cevap.data}");
    } catch (e) {
      if (e is DioError) {
        print("Dio hatası: ${e.response?.statusCode}");
        print("Hata detayı: ${e.response?.data}");
      } else {
        print("Beklenmedik bir hata oluştu: $e");
      }
    }
  }
}
