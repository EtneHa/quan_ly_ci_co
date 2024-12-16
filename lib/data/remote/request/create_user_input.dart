class CreateUserInput {
  final String ten;
  final String? ngaysinh;
  final String phongban;
  final String chucvu;
  final String? ngaybatdau;

  CreateUserInput({
    required this.ten,
    this.ngaysinh,
    required this.phongban,
    required this.chucvu,
    this.ngaybatdau,
  });

  Map<String, dynamic> toJson() => {
        'ten': ten,
        'ngaysinh': ngaysinh,
        'phongban': phongban,
        'chucvu': chucvu,
        'ngaybatdau': ngaybatdau,
      };
}