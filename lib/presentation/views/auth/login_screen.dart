import 'package:flutter_app_hotel_management/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_app_hotel_management/presentation/components/login/login_form.dart';
import 'package:flutter_app_hotel_management/presentation/views/auth/register_screen.dart';
import 'package:flutter_app_hotel_management/utils/config.dart';
import 'package:flutter_app_hotel_management/presentation/views/home/home_screen.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/logo_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginBloC = LoginBloC();

  bool isLoading = false;

  void signUserIn(BuildContext context) async {
    setState(() {
      isLoading = true; // Bắt đầu đăng nhập, hiển thị vòng tròn xoay
    });

    final String username = usernameController.text;
    final String password = passwordController.text;

    // Gọi hàm xử lý đăng nhập trong LoginBloC
    final loginResult = await loginBloC.signUserIn(username, password);

    if (loginResult.status == 200) {
      // Lưu trữ accessToken vào SharedPreferences khi đăng nhập thành công
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', loginResult.accessToken.toString());

      // Chuyển hướng đến màn hình chính (HomePage)
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Đăng nhập thất bại loi: ${loginResult.message}"),
          duration: const Duration(seconds: 3),
        ),
      );
    }

    setState(() {
      isLoading = false; // Kết thúc đăng nhập, ẩn vòng tròn xoay
    });
  }

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {
      loginBloC.usernameSink.add(usernameController.text);
    });

    passwordController.addListener(() {
      loginBloC.passSink.add(passwordController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginBloC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // Logo
                const LogoWidget(),
                Config.spaceSmall,

                // Form dang nhap
                LoginForm(
                  usernameController: usernameController,
                  passwordController: passwordController,
                  loginBloC: loginBloC,
                  signUserIn: signUserIn,
                ),
                const SizedBox(height: 50),

                // Or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),

                // dang ky tai khoan
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        // Sử dụng Navigator để chuyển hướng tới trang RegisterPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),

            // Hiển thị vòng tròn xoay khi đang đăng nhập
            if (isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
