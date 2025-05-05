import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BloodDaoRepository {
  late Dio dio; // Dio nesnesini geç başlatacağız

  BloodDaoRepository() {
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
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<void> bagisYap(
      bool currentUser,
      String name,
      String surname,
      String phoneNumber,
      String email,
      String bloodGroup,
      String age,
      String gender,
      String description,
      String hospitalId,
      String appUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    var veri = {
      "currentUser": currentUser,
      "name": name,
      "surname": surname,
      "phoneNumber": phoneNumber,
      "email": email,
      "bloodGroup": bloodGroup,
      "age": age,
      "gender": gender,
      "description": description,
      "hospitalId": hospitalId,
      "appUserId": appUserId
    };
    print("Gönderilen veri: $veri");

    try {
      var cevap = await dio.post(
        "/api/BloodDonation/AddBloodDonation",
        data: veri,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print("Kayıt başarılı: ${cevap.data}");
    } catch (e) {
      print("Hata oluştu:");
      if (e is DioError) {
        print("Dio hatası: ${e.response?.statusCode}");
        print("Hata detayı: ${e.response?.data}");
      } else {
        print("Beklenmedik bir hata: $e");
      }
    }
  }
}
