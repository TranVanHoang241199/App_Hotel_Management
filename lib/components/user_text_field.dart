import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/views/login/login_viewmodel.dart';

class UserTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final LoginViewModel loginViewModel;

  const UserTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.loginViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: StreamBuilder<String>(
        stream: loginViewModel.usernameStream,
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
