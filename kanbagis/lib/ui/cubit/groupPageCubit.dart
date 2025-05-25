import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/data/repository/groupDaoRepository.dart';

class GroupPageCubit extends Cubit<void> {
  GroupPageCubit() : super(0);
  var repo = GroupDaoRepository();
  Future<bool> grupOlustur(
    String name,
    String supervisorId,
  ) async {
    return await repo.grupOlustur(name, supervisorId);
  }

  Future<bool> grubaKullaniciEkle(
      String groupId, String email, String supervisorId) async {
    return await repo.grubaKullaniciEkle(groupId, email, supervisorId);
  }
}
