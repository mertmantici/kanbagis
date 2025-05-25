import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/colors.dart';
import 'package:kanbagis/data/entity/group.dart';
import 'package:kanbagis/ui/cubit/groupPageCubit.dart';
import 'package:kanbagis/ui/cubit/grupListeleCubit.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Grouppage extends StatefulWidget {
  const Grouppage({super.key});

  @override
  State<Grouppage> createState() => _GrouppageState();
}

class _GrouppageState extends State<Grouppage> {
  var tfName = TextEditingController();
  var tfEmail = TextEditingController();
  String? selectedGroup;
  String? userId;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadUserId();
    if (userId != null) {
      context.read<GrupListeleCubit>().gruplariListele(userId!);
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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/animations/grup.json",
                repeat: true, height: 200),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextField(
                style: const TextStyle(
                    color: MyColors.ten,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                cursorColor: MyColors.darkRed,
                controller: tfName,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.group_add,
                      color: MyColors.ten,
                      size: 30,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: MyColors.ten, width: 3)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: MyColors.ten, width: 3)),
                    hintText: "Grup için bir isim giriniz.",
                    hintStyle: const TextStyle(color: MyColors.ten)),
              ),
            ),
            Padding(
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
                    onPressed: () async {
                      if (tfName.text == "") {
                        _showSnackBar(context, 'Grup ismi boş bırakılamaz');
                      } else {
                        var succes = await context
                            .read<GroupPageCubit>()
                            .grupOlustur(tfName.text, userId!);
                        if (succes) {
                          _showSnackBar(context,
                              '${tfName.text} isimli grup başarıyla oluşturuldu');
                          setState(() {
                            tfName.text = "";
                          });
                        } else {
                          _showSnackBar(
                              context, 'Grup oluşturulurken bir hata oluştu');
                        }
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Grup Oluştur",
                        style: TextStyle(color: MyColors.white, fontSize: 22),
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BlocBuilder<GrupListeleCubit, List<Group>>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.grey[300],
                      isExpanded: true,
                      value: selectedGroup,
                      hint: const Text("Grup Seçiniz"),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGroup = newValue;
                        });
                      },
                      items: state.map((group) {
                        return DropdownMenuItem<String>(
                          value: group.id,
                          child: Text(
                            group.name,
                            style: const TextStyle(fontSize: 17),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextField(
                style: const TextStyle(
                    color: MyColors.ten,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                cursorColor: MyColors.darkRed,
                controller: tfEmail,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.mail_outline,
                      color: MyColors.ten,
                      size: 30,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: MyColors.ten, width: 3)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: MyColors.ten, width: 3)),
                    hintText: "Ekleyeceğiniz kişinin e-posta adresi.",
                    hintStyle: const TextStyle(color: MyColors.ten)),
              ),
            ),
            Padding(
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
                    onPressed: () async {
                      if (selectedGroup == null) {
                        _showSnackBar(context, 'Bir grup seçiniz');
                      } else if (tfEmail.text == "") {
                        _showSnackBar(context,
                            'Eklemek istediğiniz kullanıcının e-postası giriniz');
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(tfEmail.text)) {
                        _showSnackBar(
                            context, 'Geçerli bir e-mail adresi giriniz.');
                      } else {
                        var succes = await context
                            .read<GroupPageCubit>()
                            .grubaKullaniciEkle(
                                selectedGroup!, tfEmail.text, userId!);
                        if (succes) {
                          _showSnackBar(context,
                              '${tfEmail.text} gruba başarıyla eklendi.');
                        } else {
                          _showSnackBar(
                              context, 'Ekleme sırasında bir hata oluştu.');
                        }
                        setState(() {
                          tfEmail.text = "";
                          selectedGroup = null;
                        });
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Gruba Kullanıcı Ekle",
                        style: TextStyle(color: MyColors.white, fontSize: 22),
                      ),
                    )),
              ),
            ),
          ],
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
                color: MyColors.darkRed,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: MyColors.ten,
      ),
    );
  }
}
