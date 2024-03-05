import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/show_logout_dialog_widget.dart';
import 'package:flutter_app_hotel_management/presentation/views/System/system_screen.dart';
import 'package:flutter_app_hotel_management/presentation/views/home/home_screen.dart';
import 'package:flutter_app_hotel_management/presentation/views/profile/profile_screen.dart';
import 'package:flutter_app_hotel_management/presentation/views/retrieval/retrieval_screen.dart';
import 'package:flutter_app_hotel_management/presentation/views/setting/setting_screen.dart';
import 'package:flutter_app_hotel_management/presentation/views/statistical/statistical_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Trang chủ'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.stacked_bar_chart),
            title: Text('Thong ke'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatisticalScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.saved_search_sharp),
            title: Text('Truy xuat thong tin'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RetrievalScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.precision_manufacturing_outlined),
            title: Text('Quản lý hệ thống'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SystemScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Thong tin ca nhan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Cài đặt'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Đăng xuất'),
            onTap: () {
              showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
