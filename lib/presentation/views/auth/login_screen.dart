import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app_hotel_management/bloc/auth_bloc/auth.dart';
import 'package:flutter_app_hotel_management/presentation/components/auth/login_form.dart';
import 'package:flutter_app_hotel_management/utils/config.dart';

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
  const BodyWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginBlocCheck = LoginBlocCheck();
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {
      loginBlocCheck.usernameSink.add(usernameController.text);
    });

    passwordController.addListener(() {
      loginBlocCheck.passSink.add(passwordController.text);
    });

    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  final msg = BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
    if (state is LoginErrorState) {
      return Text(state.message);
    } else if (state is LoginLoadingState) {
      return const CircularProgressIndicator();
    } else {
      return Container();
    }
  });

  final logo = Column(
    children: [
      const Icon(
        Icons.lock,
        size: 100,
      ),
      const SizedBox(height: 50),
      Text(
        'Welcome back you\'ve been missed!',
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 16,
        ),
      ),
    ],
  );

  final dividingLine = Padding(
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
  );

  @override
  void dispose() {
    super.dispose();
    loginBlocCheck.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is LoginSuccessState) {
            Navigator.pushNamed(context, '/home');
          }
        },
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // Logo
                  logo,
                  Config.spaceSmall,
                  // Form dang nhap
                  LoginForm(
                    usernameController: usernameController,
                    passwordController: passwordController,
                    loginBlocCheck: loginBlocCheck,
                    onTap: () {
                      authBloc.add(LoginButtonPressed(
                        username: usernameController.text,
                        password: passwordController.text,
                      ));
                    },
                  ),
                  const SizedBox(height: 50),
                  // Or continue with
                  dividingLine,
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
                          Navigator.pushNamed(context, "/register");
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

              msg,
              // Hiển thị vòng tròn xoay khi đang đăng nhập
              //if (isLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
