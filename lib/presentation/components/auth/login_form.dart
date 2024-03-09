import 'package:flutter/material.dart';

import 'package:flutter_app_hotel_management/bloc/auth_bloc/auth.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/button_widget.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/pass_input_widget.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/user_input_widget.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final LoginBlocCheck loginBlocCheck;
  final Function()? onTap;

  LoginForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.loginBlocCheck,
    required this.onTap,
  });

  final forgot = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          UserTextFieldWidgets(
            controller: usernameController, // truyen Username control
            hintText: 'Username', // truyen name control
            loginBlocCheck: loginBlocCheck,
          ),
          const SizedBox(height: 10),
          PassTextFieldWidgets(
            controller: passwordController,
            hintText: 'Password',
            stream: loginBlocCheck.passStream,
          ),
          const SizedBox(height: 10),
          forgot,
          const SizedBox(height: 25),
          ButtonWidgets(
            onTap: onTap,
            loginBlocCheck: loginBlocCheck,
          ),
        ],
      ),
    );
  }
}
