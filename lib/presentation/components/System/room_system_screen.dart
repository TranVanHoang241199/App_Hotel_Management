import 'package:flutter/material.dart';

class Room {
  String name;
  String floor;
  double price;
  bool isActive;

  Room({
    required this.name,
    required this.floor,
    required this.price,
    required this.isActive,
  });
}

class RoomSystemScreen extends StatefulWidget {
  const RoomSystemScreen({Key? key}) : super(key: key);

  @override
  State<RoomSystemScreen> createState() => _RoomSystemScreenState();
}

class _RoomSystemScreenState extends State<RoomSystemScreen> {
  // Danh sách các phòng
  List<Room> roomList = [];

  // Controllers cho TextField và DropdownButton
  TextEditingController _nameController = TextEditingController();
  TextEditingController _floorController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  bool _isActive = false;

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
            child: Row(
              children: [
                Text('Active'),
                Switch(
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Thêm phòng vào danh sách khi nhấn nút thêm
                setState(() {
                  Room newRoom = Room(
                    name: _nameController.text,
                    floor: _floorController.text,
                    price: double.tryParse(_priceController.text) ?? 0,
                    isActive: _isActive,
                  );
                  roomList.add(newRoom);
                  _nameController.clear();
                  _floorController.clear();
                  _priceController.clear();
                  _isActive = false;
                });
              },
              child: Text('Add Room'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: roomList.length,
              itemBuilder: (context, index) {
                Room room = roomList[index];
                return ListTile(
                  title: Text(
                      'Name: ${room.name}\nFloor: ${room.floor}\nPrice: ${room.price}\nActive: ${room.isActive}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _floorController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
