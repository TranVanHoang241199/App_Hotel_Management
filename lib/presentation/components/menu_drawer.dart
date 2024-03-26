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
          const UserAccountsDrawerHeader(
            accountName: Text(
              'Ryan Tran',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              'Admin',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://scontent.fdad3-1.fna.fbcdn.net/v/t39.30808-6/287501340_727186358525520_5965701270680697000_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=5f2048&_nc_ohc=tn4tSZo_3esAX9hM279&_nc_ht=scontent.fdad3-1.fna&oh=00_AfAnpLtgOIzhHjL046_-f5zTVzJ0iCKKec0YGgwKN9Pmbg&oe=66080F41'),
              // backgroundImage: AssetImage(
              //     'assets/images/avatar.png'), // Thay đổi đường dẫn ảnh tương ứng
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Trang chủ'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
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
                  builder: (context) => StatisticalScreen(),
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
                  builder: (context) => RetrievalScreen(),
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
                  builder: (context) => SystemScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Hướng dẫn sử dụng'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
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
                  builder: (context) => SettingScreen(),
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
