import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/models/customer_model.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  List<CustomerModel> customers = [];

  @override
  void initState() {
    customers = [
      CustomerModel(customerName: 'John Doe', customerPhone: '123-456-7890'),
      CustomerModel(customerName: 'Jane Smith', customerPhone: '987-654-3210'),
      // Add more customers as needed
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(customers[index].customerName),
              subtitle: Text(customers[index].customerPhone),
              // You can add more widgets here for additional information
            ),
          );
        },
      ),
    );
  }
}
