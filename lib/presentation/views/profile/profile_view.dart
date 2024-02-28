import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/presentation/components/menu_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: const MenuDrawer(),
      body: Center(
        child: const Text('This is the System Management page.'),
      ),
    );
  }
}
