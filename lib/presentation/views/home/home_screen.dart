import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/presentation/views/home/customer_home_view.dart';
import 'package:flutter_app_hotel_management/presentation/views/home/history_home_view.dart';
import 'package:flutter_app_hotel_management/presentation/views/home/room_home_view.dart';
import 'package:flutter_app_hotel_management/presentation/views/home/service_home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // vi tri man hinh

  // su kien click
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      RoomHomeView(),
      ServiceHomeView(),
      CustomerHomeView(),
      HistoryHomeView(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          pages[_selectedIndex],
          // Positioned(
          //   right: 16.0,
          //   bottom: 16.0,
          //   child: OrderHomeButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => OrderScreen(),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: _MenuBotton(),
    );
  }

  Widget _MenuBotton() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.hotel),
          label: 'Phòng chờ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cleaning_services),
          label: 'Phòng đang dọn',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Khách hàng',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Dịch sử',
        ),
      ],
      fixedColor: Colors.black,
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
