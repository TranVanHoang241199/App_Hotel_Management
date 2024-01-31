import 'package:flutter/material.dart';

class CreateOrderDialog extends StatefulWidget {
  @override
  _CreateOrderDialogState createState() => _CreateOrderDialogState();
}

class _CreateOrderDialogState extends State<CreateOrderDialog> {
  final TextEditingController _customerPhoneController =
      TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tạo Hóa Đơn'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _customerPhoneController,
              decoration: const InputDecoration(labelText: 'Customer Phone'),
            ),
            TextField(
              controller: _customerNameController,
              decoration: const InputDecoration(labelText: 'Customer Name'),
            ),
            TextField(
              controller: _timeStartController,
              decoration: const InputDecoration(labelText: 'Time Start'),
            ),
            TextField(
              controller: _timeEndController,
              decoration: const InputDecoration(labelText: 'Time End'),
            ),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Note'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Đóng dialog khi nhấn nút Cancel
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Thực hiện xử lý tạo hóa đơn ở đây, sử dụng các giá trị từ các controllers
            String customerPhone = _customerPhoneController.text;
            String customerName = _customerNameController.text;
            String timeStart = _timeStartController.text;
            String timeEnd = _timeEndController.text;
            String note = _noteController.text;

            // TODO: Thực hiện xử lý tạo hóa đơn với các giá trị đã nhập

            // Đóng dialog sau khi xử lý
            Navigator.of(context).pop();
          },
          child: const Text('Create Invoice'),
        ),
      ],
    );
  }
}
