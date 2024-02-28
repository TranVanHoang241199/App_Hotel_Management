import 'package:flutter_app_hotel_management/presentation/components/login/login_form.dart';
import 'package:flutter_app_hotel_management/presentation/views/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/presentation/views/register/register_view.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/logo_widget.dart';
import 'package:flutter_app_hotel_management/utils/config.dart';

class LoginPage extends StatelessWidget {
  final LoginViewModel _loginBloc = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(loginBloc: _loginBloc),
    );
  }
}

class BodyWidget extends StatefulWidget {
  final LoginViewModel loginBloc;

  const BodyWidget({Key? key, required this.loginBloc}) : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {
      widget.loginBloc.setUsername(usernameController.text);
    });

    passwordController.addListener(() {
      widget.loginBloc.setPassword(passwordController.text);
    });
  }

  @override
  void dispose() {
    widget.loginBloc.dispose();
    super.dispose();
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
                  loginViewModel: _loginBloc,
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
                              builder: (context) => const RegisterPage()),
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
            StreamBuilder<bool>(
              stream: widget.loginBloc.btnLoginStream,
              builder: (context, snapshot) {
                bool isLoading = snapshot.data ?? false;
                return isLoading
                    ? const CircularProgressIndicator()
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
