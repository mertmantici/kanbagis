import 'package:flutter/material.dart';
import 'package:kanbagis/colors.dart';
import 'package:kanbagis/ui/views/createPage.dart';
import 'package:kanbagis/ui/views/homePage.dart';
import 'package:kanbagis/ui/views/profilePage.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  int _currentIndex = 1;
  List<Widget> body = const [
    Createpage(),
    Homepage(),
    Profilepage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.darkRed,
        title: const Center(
          child: Text(
            "Kan Bağış",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: MyColors.white),
          ),
        ),
      ),
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.create), label: "Create"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ]),
    );
  }
}
