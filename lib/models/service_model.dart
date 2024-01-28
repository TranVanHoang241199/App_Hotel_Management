import 'package:flutter_app_hotel_management/utils/enum_help.dart';

class ServiceModel {
  String? img;
  String? serviceName;
  double price;
  int quantity;
  EStatusService status;

  ServiceModel({
    this.img,
    this.serviceName,
    required this.price,
    required this.quantity,
    required this.status,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      serviceName: json['ServiceName'],
      price: json['Price'].toDouble(),
      quantity: json['Quantity'],
      status: _parseStatus(json['Status']),
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
