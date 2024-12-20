import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'package:quan_ly_ci_co/core/utils/toast.dart';
import 'package:quan_ly_ci_co/data/remote/cham_cong_repository.dart';
import 'cham_cong_state.dart';

class ChamCongCubit extends Cubit<ChamCongState> {
  ChamCongCubit()
      : super(const ChamCongState(
            screenState: BaseScreenState.none, isSuccess: false));

  final _repo = ChamCongRepository();

  Future<void> chamCong(String employeeId) async {
    emit(
        state.copyWith(screenState: BaseScreenState.loading, isSuccess: false));
    try {
      final res = await _repo.chamCong(employeeId);
      if (res?.success == false) {
        emit(state.copyWith(
            screenState: BaseScreenState.error,
            isSuccess: false,
            errorMessage: res?.message ?? 'Cham cong that bai'));

        return;
      }
      emit(state.copyWith(
        screenState: BaseScreenState.success,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        screenState: BaseScreenState.error,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void resetState() {
    emit(const ChamCongState(
        screenState: BaseScreenState.none, isSuccess: false));
  }
}
