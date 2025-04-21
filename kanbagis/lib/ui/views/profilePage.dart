import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/colors.dart';
import 'package:kanbagis/ui/cubit/profilePageCubit.dart';
import 'package:kanbagis/ui/views/loginPage.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(color: MyColors.darkRed, width: 3),
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 5.0,
                    backgroundColor: MyColors.white),
                onPressed: () async {
                  var succes =
                      await context.read<ProfilePageCubit>().cikisYap();
                  if (succes) {
                    // Kullanıcıyı LoginPage'e yönlendir
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Loginpage()));
                  }
                },
                child: const Text(
                  "Çıkış Yap",
                  style: TextStyle(
                      color: MyColors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
