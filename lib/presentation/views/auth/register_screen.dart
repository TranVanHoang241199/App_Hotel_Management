import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_bloc/auth.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositorys/auth_repository.dart';
import '../../../utils/utils.dart';
import '../../widgets/btn_register_widget.dart';
import '../../widgets/input_widget.dart';
import '../../widgets/pass_input_widget.dart';

class RegisterScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RegisterScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthInitState(), AuthRepository()),
      child: RegisterForm(),
    );
  }
}

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final msg = BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
    if (state is RegisterErrorState) {
      return Text(state.message);
    } else if (state is RegisterLoadingState) {
      return const CircularProgressIndicator();
    } else {
      return Container();
    }
  });

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    usernameController.addListener(() {
      authBloc.registerUsernameSink.add(usernameController.text);
    });
    passwordController.addListener(() {
      authBloc.registerPassSink.add(passwordController.text);
    });
    fullNameController.addListener(() {
      authBloc.registerFullNameSink.add(fullNameController.text);
    });
    phoneController.addListener(() {
      authBloc.registerPhoneSink.add(phoneController.text);
    });
    emailController.addListener(() {
      authBloc.registerEmailSink.add(emailController.text);
    });

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          // Thực hiện điều hướng sang màn hình chính ("home")
          Navigator.pushNamed(context, "/login");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Column(
                children: [
                  CustomInputFieldWidgets(
                    controller: usernameController,
                    hintText: 'Username',
                    inputType: TextInputType.text,
                    icon: Icons.person,
                    stream: authBloc.registerUsernameStream,
                  ),
                  Config.spaceSmall,
                  PassTextFieldWidgets(
                    controller: passwordController,
                    hintText: 'Password',
                    stream: authBloc.registerPassStream,
                  ),
                  Config.spaceSmall,
                  CustomInputFieldWidgets(
                    controller: fullNameController,
                    hintText: 'Họ và tên',
                    inputType: TextInputType.text,
                    icon: Icons.person,
                    stream: authBloc.registerFullNameStream,
                  ),
                  Config.spaceSmall,
                  CustomInputFieldWidgets(
                    controller: phoneController,
                    hintText: 'Số điện thoại',
                    inputType: TextInputType.phone,
                    icon: Icons.phone,
                    stream: authBloc.registerPhoneStream,
                  ),
                  Config.spaceSmall,
                  CustomInputFieldWidgets(
                    controller: emailController,
                    hintText: 'Email',
                    inputType: TextInputType.emailAddress,
                    icon: Icons.email,
                    stream: authBloc.registerEmailStream,
                  ),
                  const SizedBox(height: 20),
                  BtnRegisterWidgets(
                    authBloc: authBloc,
                    onTap: () {
                      authBloc.add(RegisterButtonPressed(
                          user: UserModel(
                        userName: usernameController.text,
                        password: passwordController.text,
                        fullName: fullNameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        businessAreas: 0,
                        isDeleted: false,
                        role: EnumHelp.getDisplayRoleText(UserRole.admin),
                      )));
                    },
                    txtName: "Register",
                  )
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
