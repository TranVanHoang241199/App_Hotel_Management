class CustomerModel {
  final String customerPhone;
  final String customerName;

  CustomerModel({required this.customerPhone, required this.customerName});

  // Factory method to create RoomViewModel from a Map
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerPhone: json['customerPhone'],
      customerName: json['customerName'],
    );
  }
}
