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
  String? createDate;
  DateTime? passwordUpdatedDate;
  DateTime? deletedDate;

  UserModel(
      {this.id,
      this.userName,
      this.password,
      this.email,
      this.fullName,
      this.phone,
      this.businessAreas,
      this.isDeleted,
      required UserRole role,
      this.createDate,
      this.passwordUpdatedDate,
      this.deletedDate})
      : role = EnumHelp.getDisplayRoleText(
            role); // chuyen thang role thanh chuoi de xu ly

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    password = json['password'];
    email = json['email'];
    fullName = json['fullName'];
    phone = json['phone'];
    businessAreas = json['businessAreas'];
    isDeleted = json['isDeleted'];
    role = json['role'];
    createDate = json['createDate'];
    passwordUpdatedDate = json['passwordUpdatedDate'];
    deletedDate = json['deletedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> User = new Map<String, dynamic>();
    User['id'] = this.id;
    User['userName'] = this.userName;
    User['password'] = this.password;
    User['email'] = this.email;
    User['fullName'] = this.fullName;
    User['phone'] = this.phone;
    User['businessAreas'] = this.businessAreas;
    User['isDeleted'] = this.isDeleted;
    User['role'] = this.role;
    User['createDate'] = this.createDate;
    User['passwordUpdatedDate'] = this.passwordUpdatedDate;
    User['deletedDate'] = this.deletedDate;
    return User;
  }
}
