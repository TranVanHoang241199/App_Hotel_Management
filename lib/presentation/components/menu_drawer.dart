import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/utils/helps/dialog_helper.dart';
import 'package:flutter_app_hotel_management/presentation/views/System/system_view.dart';
import 'package:flutter_app_hotel_management/presentation/views/home/home_view.dart';
import 'package:flutter_app_hotel_management/presentation/views/profile/profile_view.dart';
import 'package:flutter_app_hotel_management/presentation/views/retrieval/retrieval_view.dart';
import 'package:flutter_app_hotel_management/presentation/views/setting/setting_view.dart';
import 'package:flutter_app_hotel_management/presentation/views/statistical/statistical_view.dart';

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
                MaterialPageRoute(builder: (context) => const HomePage()),
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
                  builder: (context) => const StatisticalPage(),
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
                  builder: (context) => const RetrievalPage(),
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
                  builder: (context) => const SystemPage(),
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
                  builder: (context) => const ProfilePage(),
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
                  builder: (context) => const SettingPage(),
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
