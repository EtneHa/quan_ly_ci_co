import 'package:quan_ly_ci_co/data/remote/response/base_response.dart';
import 'package:quan_ly_ci_co/domain/models/user_model.dart';

class ListUserResponse extends BaseResponse {
  ListUserResponse(this.data, {required super.success, required super.message, this.totalCount});
  final List<UserData> data;
  final int? totalCount;

  factory ListUserResponse.fromJson(Map<String, dynamic> json) {
    return ListUserResponse(
      (json['data'] as List)
          .map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
      message: json['message'] as String,
      totalCount: json['total'] as int?,
    );
  }
}

class CreateUserResponse extends BaseResponse {
  CreateUserResponse(
      {required super.success, required super.message, required this.data});
  final String? data;
  factory CreateUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserResponse(
      // data: json['data']['id'] as String?,
      data: '',
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}

class UserData {
  final int? id;
  final String? ngaybatdau;
  final String? phongban;
  final String? chucvu;
  final String? ten;
  final String? ngaysinh;

  UserData({
    this.id,
    this.ngaybatdau,
    this.phongban,
    this.chucvu,
    this.ten,
    this.ngaysinh,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'] as int?,
        ngaybatdau: json['ngaybatdau'] as String?,
        phongban: json['phongban'] as String?,
        chucvu: json['chucvu'] as String?,
        ten: json['ten'] as String?,
        ngaysinh: json['ngaysinh'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'ngaybatdau': ngaybatdau,
        'phongban': phongban,
        'chucvu': chucvu,
        'ten': ten,
        'ngaysinh': ngaysinh,
      };

  UserModel toUserModel() => UserModel(
        id: id.toString(),
        name: ten,
        department: phongban,
        role: chucvu,
        onboardDate: ngaybatdau,
      );
}
