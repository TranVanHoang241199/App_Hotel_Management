import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/bloc/login_bloc/login_bloc.dart';

class ButtonWidgets extends StatelessWidget {
  final Function()? onTap;
  final LoginBloC loginBloC;

  const ButtonWidgets({Key? key, required this.onTap, required this.loginBloC})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: loginBloC.btnLoginStream,
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
