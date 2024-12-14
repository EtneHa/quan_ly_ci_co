import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  void signIn(String email, String password) {
    emit(SignInLoading());
    // Perform sign-in logic here
    // For example, call an API and handle the response
    try {
      // Simulate a network call
      Future.delayed(Duration(seconds: 2), () {
        emit(SignInSuccess());
      });
    } catch (e) {
      emit(SignInFailure(error: e.toString()));
    }
  }
}
