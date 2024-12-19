import 'package:quan_ly_ci_co/core/utils/toast.dart';
import 'package:quan_ly_ci_co/data/remote/request/cham_cong_input.dart';
import 'package:quan_ly_ci_co/data/remote/request/create_user_input.dart';
import 'package:quan_ly_ci_co/data/remote/request/pagination_params.dart';
import 'package:quan_ly_ci_co/data/remote/response/base_response.dart';
import 'package:quan_ly_ci_co/data/remote/response/cham_cong_response.dart';
import 'package:quan_ly_ci_co/data/remote/response/user_response.dart';
import 'package:quan_ly_ci_co/data/remote/rest_api.dart';

class ChamCongRepository {
  final RestApi _restApi = RestApi();

  Future<ListUserResponse?> getAll(PaginationParams pagination) async {
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

  Future<BaseResponse?> create(ChamCongInput input) async {
    try {
      final response =
          await _restApi.post('/api/employee/create', data: input.toJson());
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

  Future<ChamCongResponse?> chamCong(String id)async {
    try {
      final response = await _restApi.post('/api/employee/chamcong', data: {'id': id});
      if (response.statusCode == 200) {
        return ChamCongResponse.fromJson(response.data);
      } else {
        ToastApp.showError(response.data.message ?? response.statusMessage);
        return null;
      }
    } catch (e) {
      ToastApp.showError(e.toString());
      return null;
    }
  }

  Future<ChamCongResponse?> xoaChamCong(String id)async {
    try {
      final response = await _restApi.post('/api/employee/xoachamcong', data: {'id': id});
      if (response.statusCode == 200) {
        return ChamCongResponse.fromJson(response.data);
      } else {
        ToastApp.showError(response.data.message ?? response.statusMessage);
        return null;
      }
    } catch (e) {
      ToastApp.showError(e.toString());
      return null;
    }
  }

  Future<ChamCongResponse?> suaChamCong(ChamCongInput input)async {
    try {
      final response = await _restApi.post('/api/employee/suachamcong', data: input.toJson());
      if (response.statusCode == 200) {
        return ChamCongResponse.fromJson(response.data);
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
