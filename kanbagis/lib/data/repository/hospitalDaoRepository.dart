import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:kanbagis/data/entity/hospital.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalDaoRepository {
  late Dio dio; // Dio nesnesini geç başlatacağız

  HospitalDaoRepository() {
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

  Future<List<Hospital>> hastaneleriGetir(String city, String district) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    if (token == null) {
      throw Exception("Token bulunamadı, kullanıcı giriş yapmamış olabilir.");
    }

    var response = await dio.get(
      "/api/Hospital/GetFilteredHospitals?City=$city&District=$district",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> hospitalList = response.data;
      return hospitalList.map((e) => Hospital.fromJson(e)).toList();
    } else {
      throw Exception('Hastaneler alınamadı');
    }
  }

  Future<List<Hospital>> hastaneleriGetirWithoutDistrict(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    if (token == null) {
      throw Exception("Token bulunamadı, kullanıcı giriş yapmamış olabilir.");
    }

    var response = await dio.get(
      "/api/Hospital/GetFilteredHospitals?City=$city",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> hospitalList = response.data;
      return hospitalList.map((e) => Hospital.fromJson(e)).toList();
    } else {
      throw Exception('Hastaneler alınamadı');
    }
  }
}
