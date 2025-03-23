import 'package:flutter/material.dart';
import 'package:kanbagis/colors.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.white,
      body: Center(
        child: Text(
          "Profile Page",
          style: TextStyle(color: MyColors.darkRed),
        ),
      ),
    );
  }
}
