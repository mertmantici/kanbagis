import 'package:flutter/material.dart';
import 'package:kanbagis/colors.dart';

class Createpage extends StatefulWidget {
  const Createpage({super.key});

  @override
  State<Createpage> createState() => _CreatepageState();
}

class _CreatepageState extends State<Createpage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.white,
      body: Center(
        child: Text(
          "Create Page",
          style: TextStyle(color: MyColors.darkRed),
        ),
      ),
    );
  }
}
