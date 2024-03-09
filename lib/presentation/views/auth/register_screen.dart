import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app_hotel_management/presentation/widgets/input_widget.dart';
import 'package:flutter_app_hotel_management/data/models/user_model.dart';
import 'package:flutter_app_hotel_management/utils/utils.dart';
import '../../../bloc/auth_bloc/auth.dart';
import '../../widgets/pass_input_widget.dart';

class RegisterScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const RegisterScreen({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  late UserRole selectedRole = UserRole.admin;
  late RegisterBlocCheck registerBlocCheck;
  late AuthBloc authBloc;
  late UserModel model = UserModel(role: UserRole.admin);

  bool isDeleted = false;

  final msg = BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
    if (state is RegisterErrorState) {
      return SnackBar(
        // ignore: avoid_print
        content: Text("Đăng ký thất bại. Lỗi: " + state.message),
        duration: const Duration(seconds: 5),
      );
    } else if (state is RegisterLoadingState) {
      return const CircularProgressIndicator();
    } else {
      return Container();
    }
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = UserModel(
      userName: usernameController.text,
      password: passwordController.text,
      fullName: fullNameController.text,
      phone: phoneController.text,
      email: emailController.text,
      businessAreas: 0,
      isDeleted: isDeleted,
      role: selectedRole,
    );
    registerBlocCheck = RegisterBlocCheck();
    authBloc = BlocProvider.of<AuthBloc>(context);

    usernameController.addListener(() {
      registerBlocCheck.usernameSink.add(usernameController.text);
    });
    passwordController.addListener(() {
      registerBlocCheck.passSink.add(passwordController.text);
    });
    fullNameController.addListener(() {
      registerBlocCheck.fullNameSink.add(fullNameController.text);
    });
    phoneController.addListener(() {
      registerBlocCheck.phoneSink.add(phoneController.text);
    });
    emailController.addListener(() {
      registerBlocCheck.emailSink.add(emailController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is RegisterSuccessState) {
            Navigator.pushNamed(context, '/login');
          }
        },
        child: Padding(
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
                    stream: registerBlocCheck.usernameStream,
                  ),
                  Config.spaceSmall,
                  PassTextFieldWidgets(
                    controller: passwordController,
                    hintText: 'Password',
                    stream: registerBlocCheck.passStream,
                  ),
                  Config.spaceSmall,
                  CustomInputFieldWidgets(
                    controller: fullNameController,
                    hintText: 'Họ và tên',
                    inputType: TextInputType.text,
                    icon: Icons.person,
                    stream: registerBlocCheck.fullNameStream,
                  ),
                  Config.spaceSmall,
                  CustomInputFieldWidgets(
                    controller: phoneController,
                    hintText: 'Số điện thoại',
                    inputType: TextInputType.phone,
                    icon: Icons.phone,
                    stream: registerBlocCheck.phoneStream,
                  ),
                  Config.spaceSmall,
                  CustomInputFieldWidgets(
                    controller: emailController,
                    hintText: 'Email',
                    inputType: TextInputType.emailAddress,
                    icon: Icons.email,
                    stream: registerBlocCheck.emailStream,
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
                      authBloc.add(RegisterButtonPressed(user: model));
                    },
                    child: const Text('Register'),
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
