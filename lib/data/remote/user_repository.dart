import 'package:quan_ly_ci_co/core/utils/toast.dart';
import 'package:quan_ly_ci_co/data/remote/request/create_user_input.dart';
import 'package:quan_ly_ci_co/data/remote/request/pagination_params.dart';
import 'package:quan_ly_ci_co/data/remote/response/base_response.dart';
import 'package:quan_ly_ci_co/data/remote/response/user_response.dart';
import 'package:quan_ly_ci_co/data/remote/rest_api.dart';

class UserRepository {
  final RestApi _restApi = RestApi();

  Future<ListUserResponse?> getUserList(PaginationParams pagination) async {
    try {
      final response = await _restApi.get('/api/employee/getall',
          queryParameters: pagination.toJson());
      if (response.statusCode == 200) {
        return ListUserResponse.fromJson(response.data);
      } else {
        ToastApp.showError(response.data.message ?? response.statusMessage);
        return null;
      }
    } catch (e) {
      ToastApp.showError(e.toString());
      return null;
    }
  }

  Future<BaseResponse?> createUser(CreateUserInput user) async {
    try {
      final response =
          await _restApi.post('/api/employee/create', data: user.toJson());
      if (response.statusCode == 200) {
        return CreateUserResponse.fromJson(response.data);
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
