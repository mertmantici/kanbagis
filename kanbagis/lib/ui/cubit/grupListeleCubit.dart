import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/data/entity/group.dart';
import 'package:kanbagis/data/repository/groupDaoRepository.dart';

class GrupListeleCubit extends Cubit<List<Group>> {
  GrupListeleCubit() : super([]);
  var repo = GroupDaoRepository();
  Future<void> gruplariListele(String supervisorId) async {
    var gruplar = await repo.gruplariListele(supervisorId);
    emit(gruplar);
  }

  Future<void> kullaniciGruplariListele(String userId) async {
    var gruplar = await repo.kullaniciGruplariListele(userId);
    emit(gruplar);
  }
}
