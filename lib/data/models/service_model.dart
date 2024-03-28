class ServiceModel {
  String? id;
  String? img;
  String? serviceName;
  double priceAmount;
  int quantity;
  int status;
  //-------------
  String? categoryServiceId;
  DateTime? createdDate;
  String? createdBy;
  DateTime? modifiedDate;
  String? modifiedBy;

  ServiceModel({
    this.id,
    this.img,
    this.serviceName,
    required this.priceAmount,
    required this.quantity,
    required this.status,
    this.categoryServiceId,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img': img,
      'serviceName': serviceName,
      'priceAmount': priceAmount,
      'quantity': quantity,
      'status': status,
      'categoryServiceId': categoryServiceId,
      //---------------------------
      'createdDate': createdDate?.toIso8601String(),
      'createdBy': createdBy,
      'modifiedDate': modifiedDate?.toIso8601String(),
      'modifiedBy': modifiedBy,
    };
  }

  // static EStatusService _parseStatus(String status) {
  //   switch (status.toLowerCase()) {
  //     case 'active':
  //       return EStatusService.active;
  //     case 'end':
  //       return EStatusService.end;
  //     case 'maintenance':
  //       return EStatusService.maintenance;
  //     default:
  //       throw ArgumentError('Invalid status: $status');
  //   }
  // }
}
