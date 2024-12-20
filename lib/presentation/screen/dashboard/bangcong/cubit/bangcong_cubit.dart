import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'package:quan_ly_ci_co/core/utils/toast.dart';
import 'package:quan_ly_ci_co/data/remote/cham_cong_repository.dart';
import 'package:quan_ly_ci_co/data/remote/request/cham_cong_input.dart';
import 'package:quan_ly_ci_co/data/remote/request/pagination_params.dart';
import 'package:quan_ly_ci_co/domain/models/bangcong_model.dart';
import 'bangcong_state.dart';

class BangCongCubit extends Cubit<BangCongState> {
  BangCongCubit()
      : super(const BangCongState(screenState: BaseScreenState.none));

  final _repo = ChamCongRepository();

  void loadData() async {
    emit(state.copyWith(screenState: BaseScreenState.loading));
    try {
      // await Future.delayed(const Duration(seconds: 1));
      // final res = await _repo.getAll(PaginationParams(page: 1, limit: 10));
      // if (res?.success == false) {
      //   emit(state.copyWith(
      //       screenState: BaseScreenState.error, errorText: res?.message));
      //   return;
      // }
      emit(state.copyWith(
        screenState: BaseScreenState.success,
        chamgCongData: generateTestData()
        // chamgCongData: res?.data.map((e) => e.toBangCongModel()).toList() ?? [],
      ));
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

  Future<bool> createBangCong() async {
    try {
      final input = ChamCongInput(
          idNhanVien: state.id ?? '',
          ngay: state.date ?? '',
          gioVao: state.gioVao ?? '',
          gioRa: state.gioRa ?? '');

      final res = await _repo.create(input);
      if (res?.success == false) {
        ToastApp.showError(res?.message ?? 'Có lỗi xảy ra');
        return false;
      }
      ToastApp.showSuccess('Tạo bảng công thành công');
      return true;
    } catch (e) {
      ToastApp.showError(e.toString());
      return false;
    }
  }

  Future<bool> updateBangCong() async {
    try {
      final input = ChamCongInput(
          idNhanVien: state.id ?? '',
          ngay: state.date ?? '',
          gioVao: state.gioVao ?? '',
          gioRa: state.gioRa ?? '');

      final res = await _repo.suaChamCong(input);
      if (res?.success == false) {
        ToastApp.showError(res?.message ?? 'Có lỗi xảy ra');
        return false;
      }
      ToastApp.showSuccess('Cập nhật bảng công thành công');
      return true;
    } catch (e) {
      ToastApp.showError(e.toString());
      return false;
    }
  }

  void updateId(String p1) {
    emit(state.copyWith(id: p1));
  }

  void updateDate(String p1) {
    emit(state.copyWith(date: p1));
  }

  void updateGioVao(String p1) {
    emit(state.copyWith(gioVao: p1));
  }

  void updateGioRa(String p1) {
    emit(state.copyWith(gioRa: p1));
  }
}
