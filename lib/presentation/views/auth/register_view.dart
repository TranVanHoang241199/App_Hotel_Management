import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/bloc/register_bloc/register_bloc.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/input_widget.dart';
import 'package:flutter_app_hotel_management/data/models/user_model.dart';
import 'package:flutter_app_hotel_management/utils/config.dart';
import 'package:flutter_app_hotel_management/utils/enum_help.dart';
import 'package:flutter_app_hotel_management/presentation/views/auth/login_view.dart';

class RegisterPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const RegisterPage({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _registerBloC = RegisterBloC();
  UserRole selectedRole = UserRole.admin;

  bool isLoading = false;
  String errorMessage = '';
  bool isDeleted = false;

  Future<void> registerUser(BuildContext context) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    UserModel model = UserModel(
      userName: usernameController.text,
      password: passwordController.text,
      fullName: fullNameController.text,
      phone: phoneController.text,
      email: emailController.text,
      businessAreas: 0,
      isDeleted: isDeleted,
      role: selectedRole,
    );

    final result = await _registerBloC.registerUser(model);

    if (result.status == 200) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );

      // ignore: avoid_print
      print("Đăng ký thành công!");
      // ignore: avoid_print
      print("Thông tin tài khoản: ${result.data?.toJson()}");
    } else {
      errorMessage = result.message.toString();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // ignore: avoid_print
          content: Text("Đăng ký thất bại. Lỗi: $errorMessage"),
          duration: const Duration(seconds: 3),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInputFieldWidgets(
                  controller: usernameController,
                  hintText: 'Username',
                  inputType: TextInputType.text,
                  icon: Icons.person,
                ),
                Config.spaceSmall,
                CustomInputFieldWidgets(
                  controller: passwordController,
                  hintText: 'Password',
                  inputType: TextInputType.text,
                  icon: Icons.lock,
                ),
                Config.spaceSmall,
                CustomInputFieldWidgets(
                  controller: fullNameController,
                  hintText: 'Họ và tên',
                  inputType: TextInputType.text,
                  icon: Icons.person,
                ),
                Config.spaceSmall,
                CustomInputFieldWidgets(
                  controller: phoneController,
                  hintText: 'Số điện thoại',
                  inputType: TextInputType.phone,
                  icon: Icons.phone,
                ),
                Config.spaceSmall,
                CustomInputFieldWidgets(
                  controller: emailController,
                  hintText: 'Email',
                  inputType: TextInputType.emailAddress,
                  icon: Icons.email,
                ),
                Config.spaceSmall,
                const SizedBox(height: 20),
                // Checkbox cho trường "isDeleted"
                Row(
                  children: [
                    Checkbox(
                      value: isDeleted,
                      onChanged: (value) {
                        setState(() {
                          isDeleted = value!;
                        });
                      },
                    ),
                    const Text('Is Deleted'),
                  ],
                ),
                // Dropdown cho trường "role"
                Row(
                  children: [
                    const Text('Role: '),
                    DropdownButton<UserRole>(
                      value: selectedRole,
                      onChanged: (UserRole? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedRole = newValue;
                          });
                        }
                      },
                      items: UserRole.values.map<DropdownMenuItem<UserRole>>(
                        (UserRole role) {
                          return DropdownMenuItem<UserRole>(
                            value: role,
                            child: Text(EnumHelp.getDisplayRoleText(role)),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    registerUser(context);
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
            if (isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
