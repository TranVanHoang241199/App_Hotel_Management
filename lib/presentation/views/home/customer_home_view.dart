import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/home_bloc/home.dart';
import '../../components/menu_drawer.dart';

class CustomerHomeView extends StatelessWidget {
  const CustomerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(HomeCustomerStartEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Khách hàng"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomerSearchDelegate());
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
          BlocProvider.of<HomeBloc>(context).add(HomeCustomerStartEvent());
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeCustomerLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeCustomerSuccessState) {
              // Hiển thị danh sách phòng dưới dạng GridView
              return _buildListCustomer(state);
            } else if (state is HomeCustomerErrorState) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else if (state is HomeCustomerNoDataState) {
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

  Widget _buildListCustomer(state) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: state.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(state[index].customerName),
              subtitle: Text(state[index].customerPhone),
              // You can add more widgets here for additional information
            ),
          );
        },
      ),
    );
  }
}

class CustomerSearchDelegate extends SearchDelegate<String> {
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
