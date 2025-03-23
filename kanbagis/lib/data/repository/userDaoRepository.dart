import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class UserDaoRepository {
  late Dio dio; // Dio nesnesini geç başlatacağız

  UserDaoRepository() {
    // Dio nesnesini burada başlatıyoruz
    dio = Dio(BaseOptions(
      baseUrl: "https://10.0.2.2:7031", // API base URL
      headers: {
        "Content-Type": "application/json",
      },
      connectTimeout: Duration(seconds: 10), // Bağlantı zaman aşımı
      receiveTimeout: Duration(seconds: 10), // Yanıt zaman aşımı
    ));

    // SSL sertifika hatalarını göz ardı etmek için
    dio.httpClientAdapter = DefaultHttpClientAdapter()
      ..onHttpClientCreate = (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
  }

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
    String district,
  ) async {
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
    print("Gönderilen veridao: $veri");

    try {
      // API'ye POST isteği gönder
      var cevap = await dio.post(
        "/api/Auth/CreateUser",
        data: veri,
      );
      print("Kayıt başarılı: ${cevap.data}");
    } catch (e) {
      print("Hata oluştu");
      if (e is DioError) {
        print("Dio hatası: ${e.response?.statusCode}");
        print("Hata detayı: ${e.response?.data}");
      } else {
        print("Beklenmedik bir hata oluştu: $e");
      }
    }
  }
}
