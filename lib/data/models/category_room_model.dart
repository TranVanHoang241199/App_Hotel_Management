class CategoryRoomModel {
  final String categoryName;
  final String id;
  final DateTime createdDate;
  final String createdBy;
  final DateTime? modifiedDate;
  final String? modifiedBy;

  CategoryRoomModel({
    required this.categoryName,
    required this.id,
    required this.createdDate,
    required this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  });

  factory CategoryRoomModel.fromJson(Map<String, dynamic> json) {
    return CategoryRoomModel(
      categoryName: json['categoryname'],
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      createdBy: json['createdBy'],
      modifiedDate: json['modifiedDate'] != null
          ? DateTime.parse(json['modifiedDate'])
          : null,
      modifiedBy: json['modifiedBy'],
    );
  }
}
