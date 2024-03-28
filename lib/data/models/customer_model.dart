class CustomerModel {
  final String? identifier;
  final String? customerPhone;
  final String? customerName;

  CustomerModel({this.identifier, this.customerPhone, this.customerName});

  // Factory method to create RoomViewModel from a Map
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      identifier: json['identifier'],
      customerPhone: json['customerPhone'],
      customerName: json['customerName'],
    );
  }
}
