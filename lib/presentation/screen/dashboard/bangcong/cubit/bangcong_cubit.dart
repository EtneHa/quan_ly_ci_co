import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'package:quan_ly_ci_co/domain/models/bangcong_model.dart';
import 'bangcong_state.dart';

class BangCongCubit extends Cubit<BangCongState> {
  BangCongCubit()
      : super(const BangCongState(screenState: BaseScreenState.none));

  void loadData() async {
    emit(state.copyWith(screenState: BaseScreenState.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
          screenState: BaseScreenState.success,
          chamgCongData: generateTestData()));
    } catch (e) {
      emit(state.copyWith(
          screenState: BaseScreenState.loading, errorText: e.toString()));
    }
  }

  List<BangCongModel> generateTestData() {
    return List.generate(20, (index) {
      return BangCongModel(
        id: 'EMP${index + 1}',
        name: 'Employee ${index + 1}',
        department: 'Department ${(index % 4) + 1}',
        chamCong: List.generate(31, (dayIndex) {
          return ChamCongModel(
              label: '${dayIndex + 1}/1', checkIn: '08:00', checkOut: '17:00');
        }),
      );
    });
  }
}
