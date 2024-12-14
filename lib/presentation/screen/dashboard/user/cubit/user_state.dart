import 'package:equatable/equatable.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'package:quan_ly_ci_co/domain/models/user_model.dart';

class UserState extends Equatable {
  final BaseScreenState screenState;
  final String? errorText;
  final List<UserModel>? users;

  const UserState({
    required this.screenState,
    this.errorText,
    this.users,
  });

  UserState copyWith({
    BaseScreenState? screenState,
    String? errorText,
    List<UserModel>? users,
  }) {
    return UserState(
      screenState: screenState ?? this.screenState,
      errorText: errorText ?? this.errorText,
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [screenState, errorText, users];
}
