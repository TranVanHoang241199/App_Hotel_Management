import 'package:flutter/material.dart';

class CategoryRoomSystemScreen extends StatefulWidget {
  const CategoryRoomSystemScreen({Key? key}) : super(key: key);

  @override
  State<CategoryRoomSystemScreen> createState() =>
      _CategoryRoomSystemScreenState();
}

class _CategoryRoomSystemScreenState extends State<CategoryRoomSystemScreen> {
  // Danh sách các mục đã thêm
  List<String> itemList = [];

  // Controller cho TextField để lấy giá trị người dùng nhập
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Room System'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Enter category',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Thêm mục vào danh sách khi nhấn nút thêm
                    setState(() {
                      itemList.add(_textEditingController.text);
                      _textEditingController.clear();
                    });
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(itemList[index]),
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
    _textEditingController.dispose();
    super.dispose();
  }
}
