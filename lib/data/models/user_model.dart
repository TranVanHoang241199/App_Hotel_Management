import 'package:flutter_app_hotel_management/utils/enum_help.dart';

class UserModel {
  String? id;
  String? userName;
  String? password;
  String? email;
  String? fullName;
  String? phone;
  int? businessAreas;
  bool? isDeleted;
  String? role;

  UserModel({
    this.id,
    this.userName,
    this.password,
    this.email,
    this.fullName,
    this.phone,
    this.businessAreas,
    this.isDeleted,
    this.role,
  });

  // Factory constructor để tạo một đối tượng UserModel từ một đối tượng Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['userName'],
      password: json['password'],
      email: json['email'],
      fullName: json['fullName'],
      phone: json['phone'],
      businessAreas: json['businessAreas'],
      isDeleted: json['isDeleted'],
      role: json['role'],
    );
  }

  // Phương thức để chuyển đối tượng UserModel thành một đối tượng Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'businessAreas': businessAreas,
      'isDeleted': isDeleted,
      'role': role,
    };
  }
}
