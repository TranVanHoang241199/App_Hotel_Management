import 'package:flutter/material.dart';

import '../../bloc/auth_bloc/auth.dart';

class BtnLoginWidgets extends StatelessWidget {
  final Function()? onTap;
  final AuthBloc authBloc;
  final String txtName;

  const BtnLoginWidgets({
    Key? key,
    required this.onTap,
    required this.authBloc,
    required this.txtName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: authBloc.btnLoginStream,
      builder: (context, snapshot) {
        final canTap = snapshot.hasData && snapshot.data == true;
        return GestureDetector(
          onTap: canTap ? onTap : null,
          child: Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: canTap ? Colors.black : Colors.grey,
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
