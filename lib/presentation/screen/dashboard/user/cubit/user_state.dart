import 'package:equatable/equatable.dart';
import 'package:quan_ly_ci_co/core/apps/enums/base_screen_state.dart';
import 'package:quan_ly_ci_co/domain/models/user_model.dart';

class UserState extends Equatable {
  final BaseScreenState screenState;
  final String? errorText;
  final List<UserModel>? users;

  // Variable for create user form
  final String? fullName;
  final String? birthDay;
  final String? phoneNumber;
  final String? department;
  final String? role;
  final String? email;
  final String? onBoardingDate;

  // Pagination
  final int page;
  final int limit;
  final int total;

  const UserState({
    this.page = 1,
    this.limit = 10,
    this.total = 0,
    this.fullName,
    this.birthDay,
    this.phoneNumber,
    this.department,
    this.role,
    this.email,
    this.onBoardingDate,
    required this.screenState,
    this.errorText,
    this.users,
  });

  UserState copyWith({
    BaseScreenState? screenState,
    String? errorText,
    List<UserModel>? users,
    String? fullName,
    String? birthDay,
    String? phoneNumber,
    String? department,
    String? role,
    String? email,
    String? onBoardingDate,
    int? page,
    int? limit,
    int? total,
  }) {
    return UserState(
      screenState: screenState ?? this.screenState,
      errorText: errorText ?? this.errorText,
      users: users ?? this.users,

      // Variable for create user form
      fullName: fullName ?? this.fullName,
      birthDay: birthDay ?? this.birthDay,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      department: department ?? this.department,
      role: role ?? this.role,
      email: email ?? this.email,
      onBoardingDate: onBoardingDate ?? this.onBoardingDate,

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
        users,
        fullName,
        birthDay,
        phoneNumber,
        department,
        role,
        email,
        onBoardingDate,
        page,
        limit,
        total,
      ];
}
