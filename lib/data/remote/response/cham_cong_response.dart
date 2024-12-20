import 'package:quan_ly_ci_co/data/remote/response/base_response.dart';
import 'package:quan_ly_ci_co/domain/models/bangcong_model.dart';

class ChamCongResponse extends BaseResponse {
  ChamCongResponse({required super.success, required super.message});
  factory ChamCongResponse.fromJson(Map<String, dynamic> json) {
    return ChamCongResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}

class ListChamCongResponse extends BaseResponse {
  ListChamCongResponse(this.data,
      {required super.success, required super.message, this.totalCount});
  final List<ChamCongNhanVien> data;
  final int? totalCount;

  factory ListChamCongResponse.fromJson(Map<String, dynamic> json) {
    return ListChamCongResponse(
      (json['data'] as List)
          .map((e) => ChamCongNhanVien.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
      message: json['message'] as String,
      totalCount: json['totalCount'] as int,
    );
  }
}

class ChamCongNhanVien {
  final int? id_nhanvien;
  final String? ten;
  final String? phongban;
  final List<ChamCong>? chamCong;

  ChamCongNhanVien(
      {required this.id_nhanvien,
      required this.ten,
      required this.phongban,
      required this.chamCong});

  factory ChamCongNhanVien.fromJson(Map<String, dynamic> json) {
    return ChamCongNhanVien(
      id_nhanvien: json['id_nhanvien'] as int,
      ten: json['ten'] as String,
      phongban: json['phong_ban'] as String,
      chamCong: (json['cham_congs'] as List)
          .map((e) => ChamCong.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_nhanvien': id_nhanvien,
      'ten': ten,
      'phongban': phongban,
      'chamCong': chamCong?.map((e) => e.toJson()).toList(),
    };
  }

  BangCongModel toBangCongModel() {
    return BangCongModel(
      id: id_nhanvien.toString() ?? '',
      name: ten ?? '',
      department: phongban ?? '',
      chamCong: chamCong?.map((e) => e.toChamCongModel()).toList() ?? [],
    );
  }
}

class ChamCong {
  final String? ngay;
  final String? giovao;
  final String? giora;

  ChamCong({required this.ngay, required this.giovao, required this.giora});

  factory ChamCong.fromJson(Map<String, dynamic> json) {
    return ChamCong(
      ngay: json['ngay'] as String?,
      giovao: json['giovao'] as String?,
      giora: json['giora'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ngay': ngay,
      'giovao': giovao,
      'giora': giora,
    };
  }

  ChamCongModel toChamCongModel() {
    return ChamCongModel(
      label: ngay ?? '',
      checkIn: giovao,
      checkOut: giora,
    );
  }
}
