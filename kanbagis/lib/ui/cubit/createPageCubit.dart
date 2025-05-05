import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/data/repository/bloodDaoRepository.dart';

class CreatePageCubit extends Cubit<void> {
  CreatePageCubit() : super(0);
  var repo = BloodDaoRepository();
  Future<void> bagisYap(
      bool currentUser,
      String name,
      String surname,
      String phoneNumber,
      String email,
      String bloodGroup,
      String age,
      String gender,
      String description,
      String hospitalId,
      String appUserId) async {
    await repo.bagisYap(currentUser, name, surname, phoneNumber, email,
        bloodGroup, age, gender, description, hospitalId, appUserId);
  }
}
