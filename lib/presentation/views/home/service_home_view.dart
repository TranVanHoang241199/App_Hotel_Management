import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/utils/enum_help.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/home_bloc/home.dart';
import '../../components/menu_drawer.dart';

class ServiceHomeView extends StatelessWidget {
  const ServiceHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(HomeServiceStartEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dịch vụ"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ServiceSearchDelegate());
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
          BlocProvider.of<HomeBloc>(context).add(HomeServiceStartEvent());
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeServiceLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeServiceSuccessState) {
              // Hiển thị danh sách phòng dưới dạng GridView
              return _buildListService(state);
            } else if (state is HomeServiceErrorState) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else if (state is HomeServiceNoDataState) {
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

  Widget _buildListService(state) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: state.listService.length,
        itemBuilder: (context, index) {
          final service = state.listService[index];
          return _buildServiceItem(service);
        },
      ),
    );
  }

  Color getStatusColor(status) {
    switch (status) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.red;
      case 2:
        return Colors.grey;
      default:
        return Colors.black;
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

  Widget _buildServiceItem(service) {
    return Card(
      color: getStatusColor(service.status),
      child: ListTile(
        leading: Image.network(
          service.img.toString(),
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 60,
              color: Colors.grey, // Màu nền mặc định hoặc hình ảnh mặc định
              alignment: Alignment.center,
              child: Icon(
                Icons.image_not_supported,
                color: Colors.white,
              ),
            );
          },
        ),
        title: Text(service.serviceName.toString()),
        subtitle: Text(service.priceAmount.toString()),
        trailing: CircleAvatar(
          backgroundColor: getStatusColor(service.status),
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}

class ServiceSearchDelegate extends SearchDelegate<String> {
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
