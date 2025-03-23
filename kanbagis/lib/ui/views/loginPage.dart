import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/colors.dart';
import 'package:kanbagis/ui/views/registerPage.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/loginPageCubit.dart';
import 'anasayfa.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var tfEmail = TextEditingController();
  var tfPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/animations/kanbagis.json"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextField(
                style: const TextStyle(
                    color: MyColors.ten,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                cursorColor: MyColors.darkRed,
                controller: tfEmail,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_outlined,
                      color: MyColors.ten,
                      size: 30,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: MyColors.ten, width: 3)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: MyColors.ten, width: 3)),
                    hintText: "E-mail adresinizi giriniz.",
                    hintStyle: const TextStyle(color: MyColors.ten)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                style: const TextStyle(
                    color: MyColors.ten,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                cursorColor: MyColors.darkRed,
                controller: tfPassword,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outlined,
                      color: MyColors.ten,
                      size: 30,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: MyColors.ten, width: 3)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: MyColors.ten, width: 3)),
                    hintText: "Şifrenizi giriniz.",
                    hintStyle: const TextStyle(color: MyColors.ten)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: MyColors.ten, width: 3),
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: MyColors.red,
                    ),
                    onPressed: () async {
                      var email = tfEmail.text.trim();
                      var password = tfPassword.text.trim();
                      //kullanıcının giriş bilgileri doğruysa ana sayfaya yönlendir ve userName bilgisini shared preferencesa kaydet.
                      var success = await context
                          .read<LoginPageCubit>()
                          .kullaniciGiris(email, password);
                      if (success) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Anasayfa()));
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Giriş yap",
                        style: TextStyle(color: MyColors.white, fontSize: 22),
                      ),
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Henüz bir hesabınız yok mu?",
                  style: TextStyle(color: MyColors.ten, fontSize: 17),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Registerpage()));
                    },
                    child: const Text(
                      "Hesap Oluştur",
                      style: TextStyle(
                          color: MyColors.darkRed,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
