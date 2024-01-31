import 'package:flutter_app_hotel_management/utils/enum_help.dart';

class RoomModel {
  final String roomName;
  final int floorNumber;
  final double price;
  final int status;

  RoomModel({
    required this.roomName,
    required this.floorNumber,
    required this.price,
    required this.status,
  });

  // Factory method to create RoomViewModel from a Map
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomName: json['roomName'],
      floorNumber: json['floorNumber'],
      price: json['price'],
      status: json['status'],
    );
  }
}
