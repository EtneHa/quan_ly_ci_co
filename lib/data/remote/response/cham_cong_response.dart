import 'package:quan_ly_ci_co/data/remote/response/base_response.dart';

class ChamCongResponse extends BaseResponse{
  ChamCongResponse({required super.success, required super.message});
  factory ChamCongResponse.fromJson(Map<String, dynamic> json) {
    return ChamCongResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}