import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/components/login/login_button.dart';
import 'package:flutter_app_hotel_management/components/pass_text_field.dart';
import 'package:flutter_app_hotel_management/components/user_text_field.dart';
import 'package:flutter_app_hotel_management/views/login/login_viewmodel.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final Function(BuildContext) signUserIn;
  final LoginViewModel loginViewModel;

  LoginForm({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.signUserIn,
    required this.loginViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          UserTextField(
            controller: usernameController, // truyen Username control
            hintText: 'Username', // truyen name control
            loginViewModel: loginViewModel,
          ),
          const SizedBox(height: 10),
          PassTextField(
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
          MyButton(
            onTap: () => signUserIn(context),
            loginViewModel: loginViewModel,
          ),
        ],
      ),
    );
  }
}
