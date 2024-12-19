import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'cham_cong_state.dart';

class ChamCongCubit extends Cubit<ChamCongState> {
  ChamCongCubit()
      : super(const ChamCongState(
            screenState: BaseScreenState.none, isSuccess: false));

  Future<void> chamCong(String employeeId) async {
    emit(state.copyWith(screenState: BaseScreenState.loading, isSuccess: false));
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      emit(state.copyWith(
        screenState: BaseScreenState.success,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        screenState: BaseScreenState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void resetState() {
    emit(const ChamCongState(
        screenState: BaseScreenState.none, isSuccess: false));
  }
}
