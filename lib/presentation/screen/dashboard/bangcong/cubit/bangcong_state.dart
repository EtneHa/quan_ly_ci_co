import 'package:equatable/equatable.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'package:quan_ly_ci_co/domain/models/bangcong_model.dart';

class BangCongState extends Equatable {
  final BaseScreenState screenState;
  final String? errorText;
  final List<BangCongModel>? chamgCongData;

  const BangCongState(
      {required this.screenState, this.errorText, this.chamgCongData});

  BangCongState copyWith({
    BaseScreenState? screenState,
    String? errorText,
    List<BangCongModel>? chamgCongData,
  }) {
    return BangCongState(
      screenState: screenState ?? this.screenState,
      errorText: errorText ?? this.errorText,
      chamgCongData: chamgCongData ?? this.chamgCongData,
    );
  }

  @override
  List<Object?> get props => [
        screenState,
        errorText,
        chamgCongData,
      ];
}
