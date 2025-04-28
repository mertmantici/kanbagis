import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/ui/cubit/profilGuncelleCubit.dart';

import '../../colors.dart';

class Profilguncellepage extends StatefulWidget {
  final String userId;
  final String city;
  final String district;
  final String email;
  final String phone;
  const Profilguncellepage(
      {super.key,
      required this.userId,
      required this.city,
      required this.district,
      required this.email,
      required this.phone});

  @override
  State<Profilguncellepage> createState() => _ProfilguncellepageState();
}

class _ProfilguncellepageState extends State<Profilguncellepage> {
  var tfCity = TextEditingController();
  var tfDistrict = TextEditingController();
  var tfEmail = TextEditingController();
  var tfPhone = TextEditingController();
  var tfOldPassword = TextEditingController();
  var tfNewPassword = TextEditingController();
  @override
  void initState() {
    super.initState();
    tfCity.text = widget.city;
    tfDistrict.text = widget.district;
    tfEmail.text = widget.email;
    tfPhone.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: MyColors.white,
            )),
        backgroundColor: MyColors.red,
        title: const Text(
          "Bilgileri Güncelle",
          style: TextStyle(
            color: MyColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: TextField(
                          style: const TextStyle(
                              color: MyColors.ten,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          cursorColor: MyColors.darkRed,
                          controller: tfEmail,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email,
                                color: MyColors.ten, size: 30),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            hintText: "E-mail adresinizi giriniz",
                            hintStyle: const TextStyle(color: MyColors.ten),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: TextField(
                          style: const TextStyle(
                              color: MyColors.ten,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          cursorColor: MyColors.darkRed,
                          controller: tfPhone,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone,
                                color: MyColors.ten, size: 30),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            hintText: "Telefon numaranızı giriniz",
                            hintStyle: const TextStyle(color: MyColors.ten),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: TextField(
                          style: const TextStyle(
                              color: MyColors.ten,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          cursorColor: MyColors.darkRed,
                          controller: tfCity,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_city,
                                color: MyColors.ten, size: 30),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            hintText: "Yaşadığınız şehri giriniz",
                            hintStyle: const TextStyle(color: MyColors.ten),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: TextField(
                          style: const TextStyle(
                              color: MyColors.ten,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          cursorColor: MyColors.darkRed,
                          controller: tfDistrict,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_city,
                                color: MyColors.ten, size: 30),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            hintText: "Yaşadığınız ilçeyi giriniz",
                            hintStyle: const TextStyle(color: MyColors.ten),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: TextField(
                          obscureText: true,
                          style: const TextStyle(
                              color: MyColors.ten,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          cursorColor: MyColors.darkRed,
                          controller: tfOldPassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock,
                                color: MyColors.ten, size: 30),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            hintText: "Mevcut Şifre",
                            hintStyle: const TextStyle(color: MyColors.ten),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: TextField(
                          obscureText: true,
                          style: const TextStyle(
                              color: MyColors.ten,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          cursorColor: MyColors.darkRed,
                          controller: tfNewPassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock,
                                color: MyColors.ten, size: 30),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: MyColors.ten, width: 3),
                            ),
                            hintText: "Yeni Şifre",
                            hintStyle: const TextStyle(color: MyColors.ten),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: MyColors.darkRed, width: 3),
                              borderRadius: BorderRadius.circular(12.0)),
                          elevation: 5.0,
                          backgroundColor: MyColors.red),
                      onPressed: () async {
                        String email = tfEmail.text.trim();
                        String phone = tfPhone.text.trim();
                        String city = tfCity.text.trim();
                        String district = tfDistrict.text.trim();
                        String oldPassword = tfOldPassword.text.trim();
                        String newPassword = tfNewPassword.text.trim();
                        String cleanedPhoneNumber = phone.replaceAll(' ', '');
                        if (email.isEmpty ||
                            cleanedPhoneNumber.isEmpty ||
                            city.isEmpty ||
                            district.isEmpty ||
                            oldPassword.isEmpty ||
                            newPassword.isEmpty) {
                          _showSnackBar(
                              context, 'Lütfen alanları boş bırakmayınız.');
                          return;
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                          _showSnackBar(
                              context, 'Geçerli bir e-mail adresi giriniz.');
                          return;
                        }
                        if (newPassword.length < 6) {
                          _showSnackBar(
                              context, 'Şifre en az 6 karakter olmalıdır.');
                          return;
                        }
                        if (!RegExp(r'[A-Z]').hasMatch(newPassword)) {
                          _showSnackBar(context,
                              'Şifre en az bir büyük harf içermelidir.');
                          return;
                        }
                        if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                            .hasMatch(newPassword)) {
                          _showSnackBar(context,
                              'Şifre en az bir özel karakter içermelidir.');
                          return;
                        }

                        if (cleanedPhoneNumber.length != 11 ||
                            cleanedPhoneNumber[0] != '0') {
                          _showSnackBar(context,
                              'Telefon numaranızı önünde 0 olacak biçimde 11 karakter giriniz.');
                          return;
                        }
                        var success = await context
                            .read<ProfilGuncelleCubit>()
                            .bilgiGuncelle(widget.userId, city, district, email,
                                cleanedPhoneNumber, oldPassword, newPassword);
                        if (success) {
                          //success
                          // Kullanıcıyı LoginPage'e yönlendir
                          Navigator.pop(context);
                        } else {
                          _showSnackBar(
                              context, 'Eski şifrenizi doğru giriniz.');
                        }
                      },
                      child: const Text(
                        "Güncelle",
                        style: TextStyle(
                            color: MyColors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: const TextStyle(
                color: MyColors.darkRed,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: MyColors.ten,
      ),
    );
  }
}
