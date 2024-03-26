import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/home_bloc/home.dart';
import '../../../data/models/room_model.dart';
import '../../components/menu_drawer.dart';

class RoomHomeView extends StatelessWidget {
  const RoomHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(HomeRoomStartEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phòng"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: RoomSearchDelegate());
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Hiển thị dialog chọn option lọc
              _showFilterDialog(context);
            },
          ),
        ],
        automaticallyImplyLeading: true,
      ),
      drawer: const MenuDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          // Gửi sự kiện HomeStartEvent để load lại dữ liệu
          BlocProvider.of<HomeBloc>(context).add(HomeRoomStartEvent());
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeRoomLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeRoomSuccessState) {
              // Hiển thị danh sách phòng dưới dạng GridView
              return _buildListRoom(state);
            } else if (state is HomeRoomErrorState) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else if (state is HomeRoomNoDataState) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text("Looix khong load dc."),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListRoom(state) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Số cột là 2
          crossAxisSpacing: 10.0, // Khoảng cách giữa các cột
          mainAxisSpacing: 10.0, // Khoảng cách giữa các hàng
        ),
        itemCount: state.listRoom.length,
        itemBuilder: (context, index) {
          final room = state.listRoom[index];
          return _buildRoomItem(room);
        },
      ),
    );
  }

  Widget _buildRoomItem(RoomModel room) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Đường viền xám
        borderRadius: BorderRadius.circular(10.0), // Góc bo tròn
        color: _getStatusColor(room.status), // Màu nền của RoomItem
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(room.roomName),
          Text(room.priceAmount.toString()),
        ],
      ),
    );
  }

  Color _getStatusColor(int param) {
    switch (param) {
      case 0:
        return Colors.green.withOpacity(0.7);
      case 1:
        return Colors.yellow.withOpacity(0.7);
      case 2:
        return Colors.red.withOpacity(0.7);
      case 3:
        return Colors.white.withOpacity(0.7);
      default:
        return Colors.black.withOpacity(0.7);
    }
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Options'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Add your filter options here...'),
                // You can add various filter options here
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            // Add more buttons for filter actions if needed
          ],
        );
      },
    );
  }
}

class RoomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search Results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Type to Search...'),
    );
  }
}
