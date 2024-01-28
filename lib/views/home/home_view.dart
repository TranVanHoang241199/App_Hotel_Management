import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/views/components/home/customer_home_screen.dart';
import 'package:flutter_app_hotel_management/views/components/home/history_home_screen.dart';
import 'package:flutter_app_hotel_management/views/components/home/order_home_Button.dart';
import 'package:flutter_app_hotel_management/views/components/home/create_order_dialog.dart';
import 'package:flutter_app_hotel_management/views/components/home/room_home_screen.dart';
import 'package:flutter_app_hotel_management/views/components/home/service_home_screen.dart';
import 'package:flutter_app_hotel_management/views/components/menu_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isSearching = false;

  List<Widget> _pages = [
    const RoomHomeScreen(),
    const ServiceHomeScreen(),
    const CustomerHomeScreen(),
    const HistoryHomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _showFilterDialog(BuildContext context) async {
    // Hiển thị dialog chọn option lọc
    // Thực hiện các xử lý cần thiết
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
    });
  }

  void _showCreateOrderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateOrderDialog();
      },
    );
  }

  // Hàm này được chuyển thành biểu thức hằng
  VoidCallback get _createInvoiceCallback => _showCreateOrderDialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                decoration: const InputDecoration(
                  hintText: 'Nhập từ khóa...',
                ),
                onChanged: (query) {
                  // Xử lý thay đổi trong ô tìm kiếm
                },
              )
            : const Text("Home Page"),
        actions: [
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _startSearch,
            ),
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // Hiển thị dialog chọn option lọc
                _showFilterDialog(context);
              },
            ),
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _stopSearch,
            ),
        ],
        automaticallyImplyLeading: !_isSearching,
      ),
      drawer: const MenuDrawer(),
      body: Stack(
        children: [
          _pages[_selectedIndex],
          if (!_isSearching)
            Positioned(
              right: 16.0,
              bottom: 16.0,
              child: OrderHomeButton(
                onPressed: _createInvoiceCallback,
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'Phòng đã có khách',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Dịch sử',
          ),
        ],
        //selectedItemColor: Colors.blue,
        fixedColor: Colors.black,
        //unselectedItemColor: Colors.black,

        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        onTap: (index) => {
          setState(() {
            _selectedIndex = index;
          })
        },
      ),
    );
  }
}
