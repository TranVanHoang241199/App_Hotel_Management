import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/bloc/login_bloc/login_bloc.dart';

class PassTextFieldWidgets extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final LoginBloC loginBloC;

  const PassTextFieldWidgets({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.loginBloC,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PassTextFieldWidgetsState createState() => _PassTextFieldWidgetsState();
}

class _PassTextFieldWidgetsState extends State<PassTextFieldWidgets> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: StreamBuilder<String>(
        stream: widget.loginBloC.passStream,
        builder: (context, snapshot) {
          return TextFormField(
            controller: widget.controller,
            obscureText: _isObscured,
            validator: (value) => snapshot.data,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              errorText: snapshot.data != '' ? snapshot.data : null,
            ),
          );
        },
      ),
    );
  }
}
