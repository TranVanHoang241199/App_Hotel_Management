import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/data/models/room_model.dart';

class SystemRoomView extends StatelessWidget {
  SystemRoomView({super.key});
  // Controllers cho TextField và DropdownButton
  final _nameController = TextEditingController();
  final _floorController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;

  List<String> _categories = [
    '',
    'Category 1',
    'Category 2',
    'Category 3'
  ]; // Dan

  List<RoomModel> roomList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room System'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _floorController,
              decoration: InputDecoration(labelText: 'Floor'),
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
            child: DropdownButtonFormField(
              value: _selectedCategory,
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                // setState(() {
                //   _selectedCategory = value as String?;
                // });
              },
              decoration: InputDecoration(
                labelText: 'Select category',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       Text('Active'),
          //       Switch(
          //         value: _isActive,
          //         onChanged: (value) {
          //           setState(() {
          //             _isActive = value;
          //           });
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // // Thêm phòng vào danh sách khi nhấn nút thêm
                // setState(() {
                //   Room newRoom = Room(
                //     name: _nameController.text,
                //     floor: _floorController.text,
                //     price: double.tryParse(_priceController.text) ?? 0,
                //     isActive: _isActive,
                //   );
                //   roomList.add(newRoom);
                //   _nameController.clear();
                //   _floorController.clear();
                //   _priceController.clear();
                //   _isActive = false;
                // });
              },
              child: Text('Add Room'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: roomList.length,
              itemBuilder: (context, index) {
                RoomModel room = roomList[index];
                return ListTile(
                  title: Text(
                      'Name: ${room.roomName}\nFloor: ${room.floorNumber}\nPrice: ${room.priceAmount}'),
                );
              },
            ),
          ),
        ],
      ),
    );
    ;
  }
}
