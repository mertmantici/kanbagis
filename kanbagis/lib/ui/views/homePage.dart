import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/colors.dart';
import 'package:kanbagis/data/entity/getDonation.dart';
import 'package:kanbagis/ui/cubit/bagisListeleCubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('userId');

    if (id != null) {
      setState(() {
        userId = id;
        isLoading = false;
      });
      context.read<BagisListeleCubit>().bagislariListele(userId!);
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: MyColors.white,
      body: BlocBuilder<BagisListeleCubit, List<GetDonation>>(
        builder: (context, bagisListesi) {
          if (bagisListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: bagisListesi.length,
              itemBuilder: (context, index) {
                final bagis = bagisListesi[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                            color: MyColors.darkRed, width: 3)),
                    color: MyColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  bagis.groupName,
                                  style: const TextStyle(
                                      color: MyColors.darkRed,
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    bagis.description,
                                    style: const TextStyle(
                                        color: MyColors.red,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  bagis.nameSurname,
                                  style: const TextStyle(
                                      color: MyColors.red,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    bagis.bloodGroup,
                                    style: const TextStyle(
                                        color: MyColors.darkRed,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            bagis.phone,
                            style: const TextStyle(
                                color: MyColors.red,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            bagis.hospitalName,
                            style: const TextStyle(
                                color: MyColors.red,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  bagis.age,
                                  style: const TextStyle(
                                      color: MyColors.red,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    bagis.gender[0].toUpperCase() +
                                        bagis.gender.substring(1),
                                    style: const TextStyle(
                                        color: MyColors.red,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "Bağış Bulunamadı",
                style: TextStyle(
                    color: MyColors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            );
          }
        },
      ),
    );
  }
}
