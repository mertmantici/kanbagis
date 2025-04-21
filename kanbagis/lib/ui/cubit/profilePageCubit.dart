import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/data/repository/userDaoRepository.dart';

class ProfilePageCubit extends Cubit<bool> {
  ProfilePageCubit() : super(false);
  var repo = UserDaoRepository();
  Future<bool> cikisYap() async {
    return await repo.cikisYap();
  }
}
