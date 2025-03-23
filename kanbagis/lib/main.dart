import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/colors.dart';
import 'package:kanbagis/ui/cubit/loginPageCubit.dart';
import 'package:kanbagis/ui/cubit/registerPageCubit.dart';
import 'package:kanbagis/ui/views/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterPageCubit()),
        BlocProvider(create: (context) => LoginPageCubit()),
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
        home: const Loginpage(), //AnaSayfa()
      ),
    );
  }
}
