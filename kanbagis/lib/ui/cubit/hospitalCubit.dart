import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbagis/data/entity/hospital.dart';
import 'package:kanbagis/data/repository/hospitalDaoRepository.dart';

class HospitalCubit extends Cubit<List<Hospital>> {
  HospitalCubit() : super([]);
  var repo = HospitalDaoRepository();
  Future<void> hastaneleriGetir(String city, String? district) async {
    String formattedCity =
        city[0].toUpperCase() + city.substring(1).toLowerCase();

    if (district != null && district.isNotEmpty) {
      String formattedDistrict =
          district[0].toUpperCase() + district.substring(1).toLowerCase();
      var hastaneler =
          await repo.hastaneleriGetir(formattedCity, formattedDistrict);
      emit(hastaneler);
    } else {
      var hastaneler =
          await repo.hastaneleriGetirWithoutDistrict(formattedCity);
      emit(hastaneler);
    }
  }
}
