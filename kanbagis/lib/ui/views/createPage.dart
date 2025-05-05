import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/colors.dart';
import 'package:kanbagis/data/entity/hospital.dart';
import 'package:kanbagis/ui/cubit/createPageCubit.dart';
import 'package:kanbagis/ui/views/anasayfa.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/hospitalCubit.dart';
import '../cubit/profilePageCubit2.dart';

class Createpage extends StatefulWidget {
  const Createpage({super.key});

  @override
  State<Createpage> createState() => _CreatepageState();
}

class _CreatepageState extends State<Createpage> {
  bool currentUser = true;
  String? userId;
  String? selectedHospital;
  String? bloodGroup;
  String? age;
  double yas = 30;
  int radioDeger = 0;
  String? gender;
  var tfName = TextEditingController();
  var tfSurname = TextEditingController();
  var tfPhoneNumber = TextEditingController();
  var tfEmail = TextEditingController();
  var tfDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadUserId();
    if (userId != null) {
      await context.read<ProfilePageCubit2>().kisiGetir(userId!);
      final profil = context.read<ProfilePageCubit2>().state;
      print(
          "City: ${profil.city[0].toUpperCase() + profil.city.substring(1)}, District: ${profil.district[0].toUpperCase() + profil.district.substring(1)}");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          "city", profil.city[0].toUpperCase() + profil.city.substring(1));
      await prefs.setString("district",
          profil.district[0].toUpperCase() + profil.district.substring(1));
      await prefs.setString('ad', profil.firstName);
      await prefs.setString('soyad', profil.lastName);
      await prefs.setString('yasi', profil.age);
      await prefs.setString('cinsiyet', profil.gender);
      await prefs.setString('eposta', profil.email);
      await prefs.setString('tel', profil.phone);
      await prefs.setString('kanGrubu', profil.bloodGroup);

      context.read<HospitalCubit>().hastaneleriGetir(profil.city, "");
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
      body: currentUser
          ? Column(children: [
              const Expanded(
                  flex: 1,
                  child: Text(
                    "Bir kan, bir hayat kurtarır.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.red,
                        fontSize: 25),
                  )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Switch(
                      value: !currentUser,
                      onChanged: (bool value) {
                        setState(() {
                          currentUser = !value;
                          print("current user : $currentUser");
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Kendin için kan arıyorsun.",
                      style: TextStyle(fontSize: 20, color: MyColors.red),
                    ),
                  ],
                ),
              )),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BlocBuilder<HospitalCubit, List<Hospital>>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.grey[300],
                          isExpanded: true,
                          value: selectedHospital,
                          hint: const Text("Hastane Seçiniz"),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedHospital = newValue;
                            });
                          },
                          items: state.map((hospital) {
                            return DropdownMenuItem<String>(
                              value: hospital.id,
                              child: Text(
                                hospital.name,
                                style: const TextStyle(fontSize: 17),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              _buildTextField(tfDescription, Icons.description, "Açıklama"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: MyColors.red,
                    ),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      var ad = prefs.getString('ad');
                      var soyad = prefs.getString('soyad');
                      var yasi = prefs.getString('yasi');
                      var cinsiyet = prefs.getString('cinsiyet');
                      var eposta = prefs.getString('eposta');
                      var tel = prefs.getString('tel');
                      var kanGrubu = prefs.getString('kanGrubu');
                      if (selectedHospital == null) {
                        _showSnackBar(context, 'Lütfen bir hastane seçiniz.');
                      } else if (tfDescription.text == "") {
                        _showSnackBar(context, 'Lütfen açıklama giriniz.');
                      } else {
                        await context.read<CreatePageCubit>().bagisYap(
                            currentUser,
                            ad!,
                            soyad!,
                            tel!,
                            eposta!,
                            kanGrubu!!,
                            yasi!,
                            cinsiyet!,
                            tfDescription.text,
                            selectedHospital!,
                            userId!);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Anasayfa()));
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Kan Bul",
                        style: TextStyle(color: MyColors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ),
            ])
          : SingleChildScrollView(
              child: Column(children: [
                const Text(
                  "Bir kan, bir hayat kurtarır.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.red,
                      fontSize: 25),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Switch(
                        activeColor: MyColors.red,
                        value: !currentUser,
                        onChanged: (bool value) {
                          setState(() {
                            currentUser = !value;
                            print("current user : $currentUser");
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Başkası için kan arıyorsun.",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BlocBuilder<HospitalCubit, List<Hospital>>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedHospital,
                          hint: const Text("Hastane Seçiniz"),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedHospital = newValue;
                            });
                          },
                          items: state.map((hospital) {
                            return DropdownMenuItem<String>(
                              value: hospital.id,
                              child: Text(
                                hospital.name,
                                style: const TextStyle(fontSize: 17),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                _buildTextField(tfName, Icons.person, "İsim"),
                _buildTextField(tfSurname, Icons.person, "Soyisim"),
                _buildTextField(tfPhoneNumber, Icons.phone, "Telefon numarası"),
                _buildTextField(tfEmail, Icons.mail, "E-posta adresi"),
                const SizedBox(
                  height: 5,
                ),
                _buildBloodTypeRadios(),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Yaş : ${yas.toInt().toString()}",
                  style: const TextStyle(color: MyColors.darkRed, fontSize: 25),
                ),
                Slider(
                    activeColor: MyColors.ten,
                    min: 0.0,
                    max: 100,
                    value: yas,
                    onChanged: (veri) {
                      setState(() {
                        yas = veri;
                      });
                      age = yas.toInt().toString();
                    }),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      child: RadioListTile(
                          activeColor: MyColors.ten,
                          title: const Text(
                            "Erkek",
                            style: TextStyle(color: MyColors.darkRed),
                          ),
                          value: 1,
                          groupValue: radioDeger,
                          onChanged: (veri) {
                            setState(() {
                              radioDeger = veri!;
                            });
                            if (radioDeger == 1) {
                              gender = "Erkek";
                            }
                          }),
                    ),
                    SizedBox(
                      width: 200,
                      child: RadioListTile(
                          activeColor: MyColors.ten,
                          title: const Text(
                            "Kadın",
                            style: TextStyle(color: MyColors.darkRed),
                          ),
                          value: 2,
                          groupValue: radioDeger,
                          onChanged: (veri) {
                            setState(() {
                              radioDeger = veri!;
                            });
                            if (radioDeger == 2) {
                              gender = "Kadın";
                            }
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                _buildTextField(tfDescription, Icons.description, "Açıklama"),
                _buildDonationButton(context),
              ]),
            ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, IconData icon, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        style: const TextStyle(
            color: MyColors.ten, fontSize: 20, fontWeight: FontWeight.bold),
        cursorColor: MyColors.darkRed,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: MyColors.ten, size: 30),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: MyColors.ten, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: MyColors.ten, width: 3),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: MyColors.ten),
        ),
      ),
    );
  }

  Widget _buildBloodTypeRadios() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _radioButton("A+"),
              _radioButton("B+"),
              _radioButton("0+"),
              _radioButton("AB+"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _radioButton("A-"),
              _radioButton("B-"),
              _radioButton("0-"),
              _radioButton("AB-"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _radioButton(String value) {
    return Container(
      width: 80, // Sabit genişlik
      height: 40, // Sabit yükseklik
      margin: const EdgeInsets.symmetric(
          horizontal: 1, vertical: 2), // Chipler arasında boşluk
      child: ChoiceChip(
        label: Text(
          value,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        selected: bloodGroup == value,
        onSelected: (selected) {
          setState(() {
            bloodGroup = selected ? value : null;
          });
        },
        selectedColor: MyColors.red, // Seçili durumda arka plan rengi
        backgroundColor:
            MyColors.ten.withOpacity(0.5), // Seçili değilken arka plan rengi
        labelStyle: TextStyle(
          color: bloodGroup == value ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDonationButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: MyColors.red,
          ),
          onPressed: () async {
            String cleanedPhoneNumber = tfPhoneNumber.text.replaceAll(' ', '');
            if (bloodGroup == null) {
              _showSnackBar(context, "Lütfen kan grubunuzu seçin.");
            } else if (age == null) {
              _showSnackBar(context, "Lütfen yaşınızı seçiniz.");
            } else if (tfPhoneNumber.text.isEmpty) {
              _showSnackBar(context, "Lütfen telefon numarası giriniz.");
            } else if (tfEmail.text.isEmpty) {
              _showSnackBar(context, "Lütfen e-posta adresi giriniz.");
            } else if (gender == null) {
              _showSnackBar(context, "Lütfen cinsiyetinizi seçiniz.");
            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(tfEmail.text)) {
              _showSnackBar(context, 'Geçerli bir e-mail adresi giriniz.');
            } else if (cleanedPhoneNumber.length != 11 ||
                cleanedPhoneNumber[0] != '0') {
              _showSnackBar(context,
                  'Telefon numaranızı önünde 0 olacak biçimde 11 karakter giriniz.');
            } else if (selectedHospital == null) {
              _showSnackBar(context, 'Bir hastane seçiniz.');
            } else if (tfDescription.text == "") {
              _showSnackBar(context, 'Lütfen açıklama giriniz.');
            } else {
              await context.read<CreatePageCubit>().bagisYap(
                  currentUser,
                  tfName.text,
                  tfSurname.text,
                  cleanedPhoneNumber,
                  tfEmail.text,
                  bloodGroup!,
                  age!,
                  gender!,
                  tfDescription.text,
                  selectedHospital!,
                  userId!);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Anasayfa()));
            }
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Kan Bul",
              style: TextStyle(color: MyColors.white, fontSize: 22),
            ),
          ),
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
