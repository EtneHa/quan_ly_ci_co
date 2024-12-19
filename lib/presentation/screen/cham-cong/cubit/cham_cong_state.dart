import 'package:equatable/equatable.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';

class ChamCongState extends Equatable {
  final BaseScreenState screenState;
  final String? errorMessage;
  final bool isSuccess;

  const ChamCongState({
    this.screenState = BaseScreenState.none,
    this.errorMessage,
    this.isSuccess = false,
  });

  ChamCongState copyWith({
    BaseScreenState? screenState,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return ChamCongState(
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [screenState, errorMessage, isSuccess];
}
