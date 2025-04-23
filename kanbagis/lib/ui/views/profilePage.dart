import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/colors.dart';
import 'package:kanbagis/ui/cubit/profilePageCubit.dart';
import 'package:kanbagis/ui/views/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/entity/getUserAnswer.dart';
import '../cubit/profilePageCubit2.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String? userId;
  String? token;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadUserId();
    if (userId != null) {
      // userId null
      await context.read<ProfilePageCubit2>().kisiGetir(userId!);
    }
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: BlocBuilder<ProfilePageCubit2, GetUserAnswer>(
        builder: (context, user) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "  Hoş geldin ${user.firstName.toUpperCase()}",
                    style: const TextStyle(
                        color: MyColors.red,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: MyColors.ten, width: 3),
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 5.0,
                    color: MyColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: MyColors.red,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "${user.firstName[0].toUpperCase() + user.firstName.substring(1)} ${user.lastName[0].toUpperCase() + user.lastName.substring(1)}",
                            style: const TextStyle(
                                color: MyColors.red, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: MyColors.ten, width: 3),
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 5.0,
                    color: MyColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.mail,
                            color: MyColors.red,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            user.email,
                            style: const TextStyle(
                                color: MyColors.red, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: MyColors.ten, width: 3),
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 5.0,
                    color: MyColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          user.gender == "erkek"
                              ? const Icon(
                                  Icons.male,
                                  color: MyColors.red,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.female,
                                  color: MyColors.red,
                                  size: 30,
                                ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            user.gender[0].toUpperCase() +
                                user.gender.substring(1),
                            style: const TextStyle(
                                color: MyColors.red, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: MyColors.ten, width: 3),
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 5.0,
                    color: MyColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.bloodtype,
                            color: MyColors.red,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            user.bloodGroup.toUpperCase(),
                            style: const TextStyle(
                                color: MyColors.red, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: MyColors.ten, width: 3),
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 5.0,
                    color: MyColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: MyColors.red,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            user.age,
                            style: const TextStyle(
                                color: MyColors.red, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: MyColors.ten, width: 3),
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 5.0,
                    color: MyColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_city,
                            color: MyColors.red,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            user.city[0].toUpperCase() + user.city.substring(1),
                            style: const TextStyle(
                                color: MyColors.red, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: MyColors.ten, width: 3),
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 5.0,
                    color: MyColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_city,
                            color: MyColors.red,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            user.district[0].toUpperCase() +
                                user.district.substring(1),
                            style: const TextStyle(
                                color: MyColors.red, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: MyColors.darkRed, width: 3),
                                borderRadius: BorderRadius.circular(12.0)),
                            elevation: 5.0,
                            backgroundColor: MyColors.red),
                        onPressed: () async {
                          var success =
                              await context.read<ProfilePageCubit>().cikisYap();

                          if (success) {
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
                              color: MyColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
