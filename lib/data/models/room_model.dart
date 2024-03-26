class RoomModel {
  final String id;
  final DateTime? createdDate;
  final String? createdBy;
  final DateTime? modifiedDate;
  final String? modifiedBy;
  final String roomName;
  final int floorNumber;
  final double priceAmount;
  final int status;
  final String? categoryRoomId;

  RoomModel({
    required this.id,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
    required this.roomName,
    required this.floorNumber,
    required this.priceAmount,
    required this.status,
    this.categoryRoomId,
  });

  // Factory method to create RoomViewModel from a Map
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      createdBy: json['createdBy'],
      modifiedDate: json['modifiedDate'] != null
          ? DateTime.parse(json['modifiedDate'])
          : null,
      modifiedBy: json['modifiedBy'],
      roomName: json['roomName'],
      floorNumber: json['floorNumber'],
      priceAmount: json['priceAmount'],
      status: json['status'],
      categoryRoomId: json['categoryRoomId'],
    );
  }
}
