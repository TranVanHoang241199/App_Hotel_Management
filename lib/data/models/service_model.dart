import 'package:flutter_app_hotel_management/utils/enum_help.dart';

class ServiceModel {
  String? img;
  String? serviceName;
  double priceAmount;
  int quantity;
  int status;
  String? categoryServiceId;
  DateTime? createdDate;
  String createdBy;
  DateTime? modifiedDate;
  String? modifiedBy;

  ServiceModel({
    this.img,
    this.serviceName,
    required this.priceAmount,
    required this.quantity,
    required this.status,
    this.categoryServiceId,
    this.createdDate,
    required this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      img: json['img'],
      serviceName: json['serviceName'],
      priceAmount: json['priceAmount'].toDouble(),
      quantity: json['quantity'],
      status: json['status'],
      categoryServiceId: json['categoryServiceId'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      createdBy: json['createdBy'],
      modifiedDate: json['modifiedDate'] != null
          ? DateTime.parse(json['modifiedDate'])
          : null,
      modifiedBy: json['modifiedBy'],
    );
  }

  static EStatusService _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return EStatusService.active;
      case 'end':
        return EStatusService.end;
      case 'maintenance':
        return EStatusService.maintenance;
      default:
        throw ArgumentError('Invalid status: $status');
    }
  }
}
