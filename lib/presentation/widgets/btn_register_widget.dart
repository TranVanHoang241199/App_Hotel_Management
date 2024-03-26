import 'package:flutter/material.dart';

import '../../bloc/auth_bloc/auth.dart';

class BtnRegisterWidgets extends StatelessWidget {
  final Function()? onTap;
  final AuthBloc authBloc;
  final String txtName;

  const BtnRegisterWidgets({
    super.key,
    required this.onTap,
    required this.authBloc,
    required this.txtName,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: authBloc.btnRegisterStream,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: snapshot.data == true ? onTap : null,
          child: Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: snapshot.hasData && snapshot.data == true
                  ? Colors.black
                  : Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                txtName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
