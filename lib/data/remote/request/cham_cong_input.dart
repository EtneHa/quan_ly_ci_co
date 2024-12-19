class ChamCongInput {
  final String idNhanVien;
  final String ngay;
  final String gioVao;
  final String gioRa;

  ChamCongInput(
      {required this.idNhanVien,
      required this.ngay,
      required this.gioVao,
      required this.gioRa});

  Map<String, dynamic> toJson() => {
        'id_nhan_vien': idNhanVien,
        'ngay': ngay,
        'gio_vao': gioVao,
        'gio_ra': gioRa,
      };
}
