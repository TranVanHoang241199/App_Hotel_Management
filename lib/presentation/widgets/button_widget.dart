import 'package:flutter/material.dart';

import '../../bloc/auth_bloc/auth.dart';

class ButtonWidgets extends StatelessWidget {
  final Function()? onTap;
  final LoginBlocCheck loginBlocCheck;

  const ButtonWidgets(
      {super.key, required this.onTap, required this.loginBlocCheck});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: loginBlocCheck.btnLoginStream,
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
