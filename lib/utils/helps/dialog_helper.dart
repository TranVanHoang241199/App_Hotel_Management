import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/views/login/login_view.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Xác nhận đăng xuất'),
        content: Text('Bạn có chắc muốn đăng xuất?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // Đóng dialog và thực hiện đăng xuất
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: Text('Đăng xuất'),
          ),
        ],
      );
    },
  );
}
