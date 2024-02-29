import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/bloc/login_bloc/login_bloc.dart';

class UserTextFieldWidgets extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final LoginBloC loginBloC;

  const UserTextFieldWidgets({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.loginBloC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: StreamBuilder<String>(
        stream: loginBloC.usernameStream,
        builder: (context, snapshot) {
          return TextFormField(
            controller: controller,
            obscureText: false,
            validator: (value) => snapshot.data,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              errorText: snapshot.data != '' ? snapshot.data : null,
            ),
          );
        },
      ),
    );
  }
}
