import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/views/login/login_viewmodel.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final LoginViewModel loginViewModel;

  const MyButton({Key? key, required this.onTap, required this.loginViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: loginViewModel.btnLoginStream,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: snapshot.data == true ? onTap : null,
          child: Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: snapshot.hasData && snapshot.data == true
                  ? Colors.black
                  : Colors
                      .grey, // Màu sắc của nút thay đổi tùy thuộc vào trạng thái
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
