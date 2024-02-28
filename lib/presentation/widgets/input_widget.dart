import 'package:flutter/material.dart';

class CustomInputFieldWidgets extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final IconData icon;

  const CustomInputFieldWidgets({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.inputType,
    required this.icon,
  }) : super(key: key);

  @override
  _CustomInputFieldWidgetsState createState() =>
      _CustomInputFieldWidgetsState();
}

class _CustomInputFieldWidgetsState extends State<CustomInputFieldWidgets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
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
        ),
      ),
    );
  }
}
