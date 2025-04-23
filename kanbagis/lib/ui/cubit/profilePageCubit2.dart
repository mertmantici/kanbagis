import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/data/entity/getUserAnswer.dart';
import 'package:kanbagis/data/repository/userDaoRepository.dart';

class ProfilePageCubit2 extends Cubit<GetUserAnswer> {
  ProfilePageCubit2()
      : super(GetUserAnswer(
            firstName: "",
            lastName: "",
            bloodGroup: "",
            gender: "",
            age: "",
            city: "",
            district: "",
            email: ""));
  var repo = UserDaoRepository();
  Future<void> kisiGetir(String id) async {
    var user = await repo.kisiGetir(id);
    emit(user);
  }
}
