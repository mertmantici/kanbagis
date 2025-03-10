import 'package:flutter/material.dart';
import 'package:kanbagis/colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.darkRed,
      body: Center(
        child: Text(
          "Home Page",
          style: TextStyle(color: MyColors.white),
        ),
      ),
    );
  }
}
