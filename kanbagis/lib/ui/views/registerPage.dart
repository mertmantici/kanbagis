import 'package:flutter/material.dart';
import 'package:kanbagis/colors.dart';
import 'package:kanbagis/ui/views/loginPage.dart';
import 'package:kanbagis/ui/views/registerPageDevam.dart';
import 'package:lottie/lottie.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  var tfFirstName = TextEditingController();
  var tfLastName = TextEditingController();
  var tfEmail = TextEditingController();
  var tfPhoneNumber = TextEditingController();
  var tfPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.darkRed,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Lottie.asset("assets/animations/kanbagisredbg.json",
                  repeat: true, height: 200),
            ),
            _buildTextField(
                tfFirstName, Icons.person_outlined, "Adınızı giriniz"),
            _buildTextField(
                tfLastName, Icons.person_outlined, "Soyadınızı giriniz"),
            _buildTextField(
                tfEmail, Icons.email_outlined, "E-mail adresinizi giriniz"),
            _buildTextField(
                tfPhoneNumber, Icons.phone, "Telefon numaranızı giriniz"),
            _buildPasswordField(),
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
          cursorColor: MyColors.white,
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
                  color: MyColors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: TextField(
          style: const TextStyle(
              color: MyColors.ten, fontSize: 20, fontWeight: FontWeight.bold),
          cursorColor: MyColors.white,
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
              borderSide: const BorderSide(color: MyColors.ten, width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: MyColors.ten, width: 3),
            ),
            hintText: "Şifrenizi giriniz",
            hintStyle: const TextStyle(color: MyColors.ten),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Expanded(
      child: Padding(
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
            onPressed: () {
              String name = tfFirstName.text.trim();
              String surname = tfLastName.text.trim();
              String email = tfEmail.text.trim();
              String number = tfPhoneNumber.text.trim();
              String password = tfPassword.text.trim();

              String cleanedPhoneNumber = number.replaceAll(' ', '');

              if (name.isEmpty ||
                  surname.isEmpty ||
                  email.isEmpty ||
                  password.isEmpty ||
                  cleanedPhoneNumber.isEmpty) {
                _showSnackBar(context, 'Lütfen alanları boş bırakmayınız.');
                return;
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                _showSnackBar(context, 'Geçerli bir e-mail adresi giriniz.');
                return;
              }
              if (password.length < 6) {
                _showSnackBar(context, 'Şifre en az 6 karakter olmalıdır.');
                return;
              }
              if (!RegExp(r'[A-Z]').hasMatch(password)) {
                _showSnackBar(
                    context, 'Şifre en az bir büyük harf içermelidir.');
                return;
              }
              if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
                _showSnackBar(
                    context, 'Şifre en az bir özel karakter içermelidir.');
                return;
              }

              if (cleanedPhoneNumber.length != 11 ||
                  cleanedPhoneNumber[0] != '0') {
                _showSnackBar(context,
                    'Telefon numaranızı önünde 0 olacak biçimde 11 karakter giriniz.');
                return;
              }

              // Kullanıcı kaydını başlat
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Registerpagedevam(
                      firstName: name,
                      lastName: surname,
                      email: email,
                      phoneNumber: cleanedPhoneNumber,
                      password: password),
                ),
              );

              // Başarılı kayıt animasyonu göster
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Devam Et",
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
                color: MyColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: MyColors.ten,
      ),
    );
  }
}
