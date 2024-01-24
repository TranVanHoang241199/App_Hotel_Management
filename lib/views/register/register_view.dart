import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/components/custom_input_field.dart';
import 'package:flutter_app_hotel_management/utils/api_helper.dart';
import 'package:flutter_app_hotel_management/utils/config.dart';
import 'package:flutter_app_hotel_management/views/login/login_view.dart';

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

  bool isLoading = false;
  String errorMessage = '';
  bool isDeleted = false;
  String selectedRole = 'Adminstrator';

  Future<void> registerUser(BuildContext context) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final result = await ApiHelper.registerUser(
      username: usernameController.text,
      password: passwordController.text,
      fullName: fullNameController.text,
      phone: phoneController.text,
      email: emailController.text,
      isDeleted: isDeleted,
      role: selectedRole,
    );

    if (result['success']) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );

      // ignore: avoid_print
      print("Đăng ký thành công!");
      // ignore: avoid_print
      print("Thông tin tài khoản: ${result['data']}");
    } else {
      errorMessage = result['message'];

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
                CustomInputField(
                  controller: usernameController,
                  hintText: 'Username',
                  inputType: TextInputType.text,
                  icon: Icons.location_on,
                ),
                Config.spaceSmall,
                CustomInputField(
                  controller: passwordController,
                  hintText: 'Password',
                  inputType: TextInputType.text,
                  icon: Icons.location_on,
                ),
                Config.spaceSmall,
                CustomInputField(
                  controller: fullNameController,
                  hintText: 'Họ và tên',
                  inputType: TextInputType.text,
                  icon: Icons.person,
                ),
                Config.spaceSmall,
                CustomInputField(
                  controller: phoneController,
                  hintText: 'Số điện thoại',
                  inputType: TextInputType.phone,
                  icon: Icons.phone,
                ),
                Config.spaceSmall,
                CustomInputField(
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
                    DropdownButton<String>(
                      value: selectedRole,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRole = newValue!;
                        });
                      },
                      items: <String>['Adminstrator', 'User', 'Guest']
                          .map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
