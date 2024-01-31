import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/presentation/components/menu_drawer.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Center(
        child: const Text('This is the Setting page.'),
      ),
    );
  }
}
