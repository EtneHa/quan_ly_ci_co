import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quan_ly_ci_co/data/remote/auth_repository.dart';
import 'package:quan_ly_ci_co/data/remote/request/sign_in_input.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> signIn(String email, String password) async {
    emit(SignInLoading());
        emit(SignInSuccess());
return;
    try {
      final signInInput = SignInInput(email: email, password: password);
      final response = await AuthRepository().signIn(signInInput);
      if (response?.success ?? false) {
        emit(SignInSuccess());
        return;
      }
      emit(SignInFailure(error: response?.message ?? 'Đăng nhập thất bại'));
    } catch (e) {
      emit(SignInFailure(error: e.toString()));
    }
  }
}
