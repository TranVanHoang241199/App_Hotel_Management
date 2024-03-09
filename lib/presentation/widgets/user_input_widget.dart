import 'package:flutter/material.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';

class UserTextFieldWidgets extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final LoginBlocCheck loginBlocCheck;

  const UserTextFieldWidgets({
    super.key,
    required this.controller,
    required this.hintText,
    required this.loginBlocCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: StreamBuilder<String>(
        stream: loginBlocCheck.usernameStream,
        builder: (context, snapshot) {
          return TextFormField(
            controller: controller,
            obscureText: false,
            validator: (value) => snapshot.data,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
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
