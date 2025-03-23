import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/colors.dart';
import 'package:kanbagis/ui/cubit/registerPageCubit.dart';
import 'package:lottie/lottie.dart';

import 'loginPage.dart';

class Registerpagedevam extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;

  const Registerpagedevam(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.password});

  @override
  State<Registerpagedevam> createState() => _RegisterpagedevamState();
}

class _RegisterpagedevamState extends State<Registerpagedevam> {
  var tfCity = TextEditingController();
  var tfDistrict = TextEditingController();
  String? gender;
  String? bloodGroup;
  String? age;
  int radioDeger = 0;
  double yas = 30.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Lottie.asset("assets/animations/kanbagis.json",
                  repeat: true, height: 200),
            ),
            _buildTextField(
                tfCity, Icons.location_city, "Yaşadığınız şehri giriniz"),
            _buildTextField(
                tfDistrict, Icons.location_city, "Yaşadığınız ilçeyi giriniz"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: RadioListTile(
                      activeColor: MyColors.ten,
                      title: const Text(
                        "Erkek",
                        style: TextStyle(color: MyColors.darkRed),
                      ),
                      value: 1,
                      groupValue: radioDeger,
                      onChanged: (veri) {
                        setState(() {
                          radioDeger = veri!;
                        });
                        if (radioDeger == 1) {
                          gender = "Erkek";
                        }
                      }),
                ),
                SizedBox(
                  width: 200,
                  child: RadioListTile(
                      activeColor: MyColors.ten,
                      title: const Text(
                        "Kadın",
                        style: TextStyle(color: MyColors.darkRed),
                      ),
                      value: 2,
                      groupValue: radioDeger,
                      onChanged: (veri) {
                        setState(() {
                          radioDeger = veri!;
                        });
                        if (radioDeger == 2) {
                          gender = "Kadın";
                        }
                      }),
                ),
              ],
            ),
            Text(
              "Yaş : ${yas.toInt().toString()}",
              style: const TextStyle(color: MyColors.darkRed, fontSize: 25),
            ),
            Slider(
                activeColor: MyColors.ten,
                min: 0.0,
                max: 100,
                value: yas,
                onChanged: (veri) {
                  setState(() {
                    yas = veri;
                  });
                  age = yas.toInt().toString();
                }),
            _buildBloodTypeRadios(),
            _buildRegisterButton(context),
            _buildLoginRedirect(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, IconData icon, String hint) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: TextField(
          style: const TextStyle(
              color: MyColors.ten, fontSize: 20, fontWeight: FontWeight.bold),
          cursorColor: MyColors.darkRed,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: MyColors.ten, size: 30),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: MyColors.ten, width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: MyColors.ten, width: 3),
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: MyColors.ten),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginRedirect() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Zaten hesabın var mı?",
            style: TextStyle(color: MyColors.ten, fontSize: 17),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Loginpage()));
            },
            child: const Text(
              "Giriş Yap",
              style: TextStyle(
                  color: MyColors.darkRed,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodTypeRadios() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _radioButton("A+"),
              _radioButton("B+"),
              _radioButton("0+"),
              _radioButton("AB+"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _radioButton("A-"),
              _radioButton("B-"),
              _radioButton("0-"),
              _radioButton("AB-"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _radioButton(String value) {
    return Container(
      width: 80, // Sabit genişlik
      height: 40, // Sabit yükseklik
      margin: const EdgeInsets.symmetric(
          horizontal: 1, vertical: 2), // Chipler arasında boşluk
      child: ChoiceChip(
        label: Text(
          value,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        selected: bloodGroup == value,
        onSelected: (selected) {
          setState(() {
            bloodGroup = selected ? value : null;
          });
        },
        selectedColor: MyColors.red, // Seçili durumda arka plan rengi
        backgroundColor:
            MyColors.ten.withOpacity(0.5), // Seçili değilken arka plan rengi
        labelStyle: TextStyle(
          color: bloodGroup == value ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: MyColors.red,
            ),
            onPressed: () {
              if (bloodGroup == null) {
                _showSnackBar(context, "Lütfen kan grubunuzu seçin.");
              } else if (age == null) {
                _showSnackBar(context, "Lütfen yaşınızı seçiniz.");
              } else if (tfCity.text.isEmpty) {
                _showSnackBar(context, "Lütfen yaşadığınız şehri giriniz.");
              } else if (tfDistrict.text.isEmpty) {
                _showSnackBar(context, "Lütfen yaşadığınız ilçeyi giriniz.");
              } else if (gender == null) {
                _showSnackBar(context, "Lütfen cinsiyetinizi seçiniz.");
              } else {
                context.read<RegisterPageCubit>().kisiKayit(
                    widget.firstName,
                    widget.lastName,
                    widget.email,
                    widget.phoneNumber,
                    widget.password,
                    bloodGroup!,
                    gender!,
                    age!,
                    tfCity.text,
                    tfDistrict.text);
                _showLottieDialog(); // Başarı animasyonu gösterilir
                print(
                    "${widget.firstName} ${widget.lastName} ${widget.email} ${widget.phoneNumber} ${widget.password} $bloodGroup $age $gender ");
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Kayıt Ol",
                style: TextStyle(color: MyColors.white, fontSize: 22),
              ),
            ),
          ),
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

  void _showLottieDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            color: Colors.transparent,
            child: Lottie.asset(
              'assets/animations/basari.json',
              width: 400,
              height: 400,
              repeat: false,
              onLoaded: (composition) {
                Future.delayed(composition.duration, () {
                  Navigator.of(context).pop(); // Dialogu kapatma

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Loginpage()),
                  );
                });
              },
            ),
          ),
        );
      },
    );
  }
}
