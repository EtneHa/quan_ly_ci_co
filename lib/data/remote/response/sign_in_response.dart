import 'package:quan_ly_ci_co/data/remote/response/base_response.dart';

class SignInResponse extends BaseResponse{
  SignInResponse({required super.success, required super.message});

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}