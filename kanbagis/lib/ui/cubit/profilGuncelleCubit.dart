import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/data/repository/userDaoRepository.dart';

class ProfilGuncelleCubit extends Cubit<bool> {
  ProfilGuncelleCubit() : super(false);
  var repo = UserDaoRepository();
  Future<bool> bilgiGuncelle(
      String id,
      String city,
      String district,
      String email,
      String phone,
      String oldPassword,
      String newPassword) async {
    return await repo.bilgiGuncelle(
        id, city, district, email, phone, oldPassword, newPassword);
  }
}
