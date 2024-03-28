import 'package:flutter/material.dart';

import 'package:flutter_app_hotel_management/presentation/views/System/system_category_room_view.dart';
import 'package:flutter_app_hotel_management/presentation/views/System/system_category_service_view.dart';
import 'package:flutter_app_hotel_management/presentation/views/System/system_room_view.dart';
import 'package:flutter_app_hotel_management/presentation/views/System/system_service_view.dart';
import 'package:flutter_app_hotel_management/presentation/components/menu_drawer.dart';

class SystemScreen extends StatelessWidget {
  const SystemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Management'),
      ),
      drawer: const MenuDrawer(),
      body: GridView.count(
        crossAxisCount: 2, // Số cột trong mỗi hàng
        children: [
          CustomSquareButton(
            buttonText: 'Loại phòng',
            icon: Icons.home_work_outlined,
            onPressed: () {
              _handleButtonPress(context, 1); // Truyền context vào hàm
            },
          ),
          CustomSquareButton(
            buttonText: 'Phòng',
            icon: Icons.hotel,
            onPressed: () {
              _handleButtonPress(context, 2); // Truyền context vào hàm
            },
          ),
          CustomSquareButton(
            buttonText: 'Loại phòng dịch vụ',
            icon: Icons.menu_book_sharp,
            onPressed: () {
              _handleButtonPress(context, 3); // Truyền context vào hàm
            },
          ),
          CustomSquareButton(
            buttonText: 'Dịch vụ',
            icon: Icons.room_service,
            onPressed: () {
              _handleButtonPress(context, 4); // Truyền context vào hàm
            },
          ),
          CustomSquareButton(
            buttonText: 'Cách tính tiền',
            icon: Icons.calculate,
            onPressed: () {
              _handleButtonPress(context, 5); // Truyền context vào hàm
            },
          ),
        ],
      ),
    );
  }

  void _handleButtonPress(BuildContext context, int buttonNumber) {
    // Thêm tham số context
    switch (buttonNumber) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SystemCategoryRoomView()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SystemRoomView()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SystemCategoryServiceView()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SystemServiceView()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondPage()),
        );
        break;
      // Thêm các trường hợp khác nếu cần
    }
  }
}

class CustomSquareButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double size;
  final IconData icon;

  const CustomSquareButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.size = 50.0, // Kích thước mặc định
    this.icon =
        Icons.check, // Icon mặc định, bạn có thể thay đổi thành icon mong muốn
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          //color: Color.fromARGB(255, 212, 219, 224), // Màu nền của nút
          border: Border.all(
            color: Colors.black, // Màu đường viền
            width: 0.5, // Độ dày của đường viền
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24, // Kích thước của icon
              color: Colors.black, // Màu của icon
            ),
            SizedBox(height: 8), // Khoảng cách giữa icon và văn bản
            Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black, // Màu văn bản
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: Center(
        child: const Text('This is the First Page.'),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: const Text('This is the Second Page.'),
      ),
    );
  }
}
