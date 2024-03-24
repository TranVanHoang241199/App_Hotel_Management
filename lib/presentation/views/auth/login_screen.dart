import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app_hotel_management/bloc/auth_bloc/auth.dart';

import '../../../data/repositorys/auth_repository.dart';
import '../../widgets/btn_login_widget.dart';
import '../../widgets/pass_input_widget.dart';
import '../../widgets/user_input_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthInitState(), AuthRepository()),
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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

  final msg = BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
    if (state is LoginErrorState) {
      return Text(state.message);
    } else if (state is LoginLoadingState) {
      return Center(child: const CircularProgressIndicator());
    } else {
      return Container();
    }
  });

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    usernameController.addListener(() {
      authBloc.loginUsernameSink.add(usernameController.text);
    });

    passwordController.addListener(() {
      authBloc.loginPassSink.add(passwordController.text);
    });

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          // Thực hiện điều hướng sang màn hình chính ("home")
          Navigator.pushNamed(context, "/home");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserTextFieldWidgets(
                    controller: usernameController,
                    hintText: 'Username',
                    stream: authBloc.loginUsernameStream,
                  ),
                  const SizedBox(height: 10),
                  PassTextFieldWidgets(
                    controller: passwordController,
                    hintText: 'Password',
                    stream: authBloc.loginPassStream,
                  ),
                  const SizedBox(height: 10),
                  forgot,
                  const SizedBox(height: 25),
                  BtnLoginWidgets(
                    txtName: "Login",
                    onTap: () {
                      authBloc.add(LoginButtonPressed(
                        username: usernameController.text,
                        password: passwordController.text,
                      ));
                    },
                    authBloc: authBloc,
                  ),
                ],
              ),
              msg,
            ],
          ),
        ),
      ),
    );
  }
}
