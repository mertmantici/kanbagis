import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/data/repository/userDaoRepository.dart';

class LoginPageCubit extends Cubit<bool> {
  LoginPageCubit() : super(false);
  var repo = UserDaoRepository();
  Future<bool> kullaniciGiris(String email, String password) async {
    return await repo.kullaniciGiris(email, password);
  }
}
