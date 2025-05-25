import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/data/entity/getDonation.dart';
import 'package:kanbagis/data/repository/bloodDaoRepository.dart';

class BagisListeleCubit extends Cubit<List<GetDonation>> {
  BagisListeleCubit() : super([]);
  var repo = BloodDaoRepository();
  Future<void> bagislariListele(String userId) async {
    var bagislar = await repo.bagislariListele(userId);
    emit(bagislar);
  }
}
