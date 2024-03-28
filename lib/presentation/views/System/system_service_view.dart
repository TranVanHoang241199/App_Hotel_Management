import 'package:flutter/material.dart';

enum ServiceStatus {
  available,
  outOfStock,
  underMaintenance,
}

class Service {
  String name;
  double price;
  int quantity;
  ServiceStatus status;

  Service({
    required this.name,
    required this.price,
    required this.quantity,
    required this.status,
  });
}

class ServiceSystemScreen extends StatefulWidget {
  const ServiceSystemScreen({Key? key}) : super(key: key);

  @override
  _ServiceSystemScreenState createState() => _ServiceSystemScreenState();
}

class _ServiceSystemScreenState extends State<ServiceSystemScreen> {
  List<Service> serviceList = [];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  ServiceStatus _selectedStatus = ServiceStatus.available;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service System'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Service Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<ServiceStatus>(
              value: _selectedStatus,
              onChanged: (ServiceStatus? value) {
                setState(() {
                  _selectedStatus = value ?? ServiceStatus.available;
                });
              },
              items: ServiceStatus.values
                  .map((status) => DropdownMenuItem<ServiceStatus>(
                        value: status,
                        child: Text(_statusToString(status)),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Thêm dịch vụ vào danh sách khi nhấn nút thêm
                setState(() {
                  Service newService = Service(
                    name: _nameController.text,
                    price: double.tryParse(_priceController.text) ?? 0,
                    quantity: int.tryParse(_quantityController.text) ?? 0,
                    status: _selectedStatus,
                  );
                  serviceList.add(newService);
                  _nameController.clear();
                  _priceController.clear();
                  _quantityController.clear();
                  _selectedStatus = ServiceStatus.available;
                });
              },
              child: Text('Add Service'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: serviceList.length,
              itemBuilder: (context, index) {
                Service service = serviceList[index];
                return ListTile(
                  title: Text(
                      'Name: ${service.name}\nPrice: ${service.price}\nQuantity: ${service.quantity}\nStatus: ${_statusToString(service.status)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _statusToString(ServiceStatus status) {
    switch (status) {
      case ServiceStatus.available:
        return 'Available';
      case ServiceStatus.outOfStock:
        return 'Out of Stock';
      case ServiceStatus.underMaintenance:
        return 'Under Maintenance';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}

