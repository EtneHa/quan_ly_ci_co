class BangCongModel {
  final String id;
  final String name;
  final String department;
  final List<ChamCongModel> chamCong;

  BangCongModel({
    required this.id, 
    required this.name, 
    required this.department, 
    required this.chamCong
  });

  factory BangCongModel.fromJson(Map<String, dynamic> json) {
    return BangCongModel(
      id: json['id'] as String,
      name: json['name'] as String,
      department: json['department'] as String,
      chamCong: (json['chamCong'] as List)
          .map((e) => ChamCongModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'chamCong': chamCong.map((e) => e.toJson()).toList(),
    };
  }
}

class ChamCongModel {
  final String label;
  final String? checkIn;
  final String? checkOut;

  ChamCongModel({
    required this.label, 
    this.checkIn, 
    this.checkOut
  });

  factory ChamCongModel.fromJson(Map<String, dynamic> json) {
    return ChamCongModel(
      label: json['label'] as String,
      checkIn: json['checkIn'] as String?,
      checkOut: json['checkOut'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'checkIn': checkIn,
      'checkOut': checkOut,
    };
  }
}