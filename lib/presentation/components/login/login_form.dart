import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/button_widget.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/pass_input_widget.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/user_input_widget.dart';
import 'package:flutter_app_hotel_management/presentation/views/login/login_viewmodel.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final LoginViewModel loginViewModel;

  LoginForm({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.loginViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          UserTextFieldWidgets(
            controller: usernameController,
            hintText: 'Username',
            loginViewModel: loginViewModel,
          ),
          const SizedBox(height: 10),
          PassTextFieldWidgets(
            controller: passwordController,
            hintText: 'Password',
            loginViewModel: loginViewModel,
          ),
          const SizedBox(height: 10),
          Padding(
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
          ),
          const SizedBox(height: 25),
          ButtonWidgets(
            onTap: () => loginViewModel.signUserIn(context),
            loginViewModel: loginViewModel,
          ),
        ],
      ),
    );
  }
}
