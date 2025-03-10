import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/data/repository/userDaoRepository.dart';

class RegisterPageCubit extends Cubit<void> {
  RegisterPageCubit() : super(0);
  var repo = UserDaoRepository();
  Future<void> kisiKayit(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      String bloodGroup,
      String gender,
      String age,
      String city,
      String district) async {
    await repo.kisiKayit(firstName, lastName, email, phoneNumber, password,
        bloodGroup, gender, age, city, district);
  }
}
