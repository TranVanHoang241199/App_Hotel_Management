class CategoryServiceModel {
  final String? id;
  final DateTime? createdDate;
  final String? createdBy;
  final DateTime? modifiedDate;
  final String? modifiedBy;
  final String? categoryName;

  CategoryServiceModel({
    this.id,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    this.categoryName,
  });

  factory CategoryServiceModel.fromJson(Map<String, dynamic> json) {
    return CategoryServiceModel(
      id: json['id'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      createdBy: json['createdBy'],
      modifiedDate: json['modifiedDate'] != null
          ? DateTime.parse(json['modifiedDate'])
          : null,
      modifiedBy: json['modifiedBy'],
      categoryName: json['categoryname'],
    );
  }
}
