import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:kanbagis/data/entity/group.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupDaoRepository {
  late Dio dio; // Dio nesnesini geç başlatacağız

  GroupDaoRepository() {
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

  Future<bool> grupOlustur(
    String name,
    String supervisorId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    var veri = {
      "name": name,
      "supervisorId": supervisorId,
    };
    print("Gönderilen veri: $veri");

    try {
      var cevap = await dio.post(
        "/Group/CreateGroup",
        data: veri,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print("Kayıt başarılı: ${cevap.data}");
      return true;
    } catch (e) {
      print("Hata oluştu:");
      if (e is DioError) {
        print("Dio hatası: ${e.response?.statusCode}");
        print("Hata detayı: ${e.response?.data}");
      } else {
        print("Beklenmedik bir hata: $e");
      }
      return false;
    }
  }

  Future<bool> grubaKullaniciEkle(
    String groupId,
    String email,
    String supervisorId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    var veri = {
      "groupId": groupId,
      "email": email,
      "supervisorId": supervisorId,
    };
    print("Gönderilen veri: $veri");

    try {
      var cevap = await dio.post(
        "/Group/AddUserToGroup",
        data: veri,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print("Kayıt başarılı: ${cevap.data}");
      return true;
    } catch (e) {
      print("Hata oluştu:");
      if (e is DioError) {
        print("Dio hatası: ${e.response?.statusCode}");
        print("Hata detayı: ${e.response?.data}");
      } else {
        print("Beklenmedik bir hata: $e");
      }
      return false;
    }
  }

  Future<List<Group>> gruplariListele(String supervisorId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    var veri = {
      "supervisorId": supervisorId,
    };
    print("Gönderilen veri: $veri");

    try {
      var cevap = await dio.post(
        "/Group/GetGroupBySupervisorId",
        data: veri,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (cevap.statusCode == 200) {
        List<dynamic> groupList = cevap.data;
        return groupList.map((e) => Group.fromJson(e)).toList();
      } else {
        throw Exception('Gruplar alınamadı');
      }
    } catch (e) {
      print("Hata oluştu:");
      if (e is DioError) {
        print("Dio hatası: ${e.response?.statusCode}");
        print("Hata detayı: ${e.response?.data}");
      } else {
        print("Beklenmedik bir hata: $e");
      }
      return [];
    }
  }

  Future<List<Group>> kullaniciGruplariListele(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    var veri = {
      "userId": userId,
    };
    print("Gönderilen veri: $veri");

    try {
      var cevap = await dio.post(
        "/Group/GetGroupByUserId",
        data: veri,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (cevap.statusCode == 200) {
        List<dynamic> groupList = cevap.data;
        return groupList.map((e) => Group.fromJson(e)).toList();
      } else {
        throw Exception('Gruplar alınamadı');
      }
    } catch (e) {
      print("Hata oluştu:");
      if (e is DioError) {
        print("Dio hatası: ${e.response?.statusCode}");
        print("Hata detayı: ${e.response?.data}");
      } else {
        print("Beklenmedik bir hata: $e");
      }
      return [];
    }
  }
}
