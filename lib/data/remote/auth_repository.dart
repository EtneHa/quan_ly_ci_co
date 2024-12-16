import 'package:quan_ly_ci_co/core/utils/toast.dart';
import 'package:quan_ly_ci_co/data/remote/request/sign_in_input.dart';
import 'package:quan_ly_ci_co/data/remote/response/sign_in_response.dart';
import 'package:quan_ly_ci_co/data/remote/rest_api.dart';

class AuthRepository {
  AuthRepository();
  final RestApi _restApi = RestApi();

  Future<SignInResponse?> signIn(SignInInput user) async {
    try {
      final response =
          await _restApi.post('/api/auth/login', data: user.toJson());
      if (response.statusCode == 200) {
        return SignInResponse.fromJson(response.data);
      } else {
        ToastApp.showError(response.data.message ?? response.statusMessage);
        return null;
      }
    } catch (e) {
      ToastApp.showError(e.toString());
      return null;
    }
  }
}
