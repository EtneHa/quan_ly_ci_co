import 'package:equatable/equatable.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'package:quan_ly_ci_co/domain/models/bangcong_model.dart';

class BangCongState extends Equatable {
  final BaseScreenState screenState;
  final String? errorText;
  final List<BangCongModel>? chamgCongData;

  final String? id;
  final String? date;
  final String? gioVao;
  final String? gioRa;

  // Pagination
  final int page;
  final int limit;
  final int total;

  const BangCongState(
      {this.id,
      this.date,
      this.gioVao,
      this.gioRa,
      required this.screenState,
      this.limit = 10,
      this.total = 0,
      this.page = 1,
      this.errorText,
      this.chamgCongData});

  BangCongState copyWith(
      {BaseScreenState? screenState,
      String? errorText,
      List<BangCongModel>? chamgCongData,
      String? id,
      String? date,
      String? gioVao,
      String? gioRa,
      int? total,
      int? limit,
      int? page}) {
    return BangCongState(
      screenState: screenState ?? this.screenState,
      errorText: errorText ?? this.errorText,
      chamgCongData: chamgCongData ?? this.chamgCongData,
      id: id ?? this.id,
      date: date ?? this.date,
      gioVao: gioVao ?? this.gioVao,
      gioRa: gioRa ?? this.gioRa,
      // Pagination
      page: page ?? this.page,
      limit: limit ?? this.limit,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [
        screenState,
        errorText,
        chamgCongData,
        id,
        date,
        gioVao,
        gioRa,
        page,
        total,
        limit
      ];
}
