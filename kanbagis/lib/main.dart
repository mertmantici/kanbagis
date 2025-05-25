import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/colors.dart';
import 'package:kanbagis/ui/cubit/bagisListeleCubit.dart';
import 'package:kanbagis/ui/cubit/createPageCubit.dart';
import 'package:kanbagis/ui/cubit/groupPageCubit.dart';
import 'package:kanbagis/ui/cubit/grupListeleCubit.dart';
import 'package:kanbagis/ui/cubit/hospitalCubit.dart';
import 'package:kanbagis/ui/cubit/loginPageCubit.dart';
import 'package:kanbagis/ui/cubit/profilGuncelleCubit.dart';
import 'package:kanbagis/ui/cubit/profilePageCubit.dart';
import 'package:kanbagis/ui/cubit/profilePageCubit2.dart';
import 'package:kanbagis/ui/cubit/registerPageCubit.dart';
import 'package:kanbagis/ui/views/anasayfa.dart';
import 'package:kanbagis/ui/views/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterPageCubit()),
        BlocProvider(create: (context) => LoginPageCubit()),
        BlocProvider(create: (context) => ProfilePageCubit()),
        BlocProvider(create: (context) => ProfilePageCubit2()),
        BlocProvider(create: (context) => ProfilGuncelleCubit()),
        BlocProvider(create: (context) => HospitalCubit()),
        BlocProvider(create: (context) => CreatePageCubit()),
        BlocProvider(create: (context) => GroupPageCubit()),
        BlocProvider(create: (context) => GrupListeleCubit()),
        BlocProvider(create: (context) => BagisListeleCubit()),
      ],
      child: MaterialApp(
        title: "Kan Bağış",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: MyColors.white,
            unselectedItemColor: MyColors.ten,
            selectedItemColor: MyColors.darkRed,
            selectedIconTheme: IconThemeData(size: 35),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: MyColors.white),
          useMaterial3: true,
        ),
        home: isLoggedIn == null
            ? const Center(child: CircularProgressIndicator())
            : (isLoggedIn == true ? const Anasayfa() : const Loginpage()),
      ),
    );
  }
}
