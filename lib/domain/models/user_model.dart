class UserModel {
  final String? id;
  final String? name;
  final String? department;
  final String? role;
  final String? onboardDate;

  UserModel({
    this.id,
    this.name,
    this.department,
    this.role,
    this.onboardDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'role': role,
      'onboardDate': onboardDate,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      department: json['department'] as String?,
      role: json['role'] as String?,
      onboardDate: json['onboardDate'] as String?,
    );
  }
}