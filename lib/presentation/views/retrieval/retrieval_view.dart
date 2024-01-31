import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/presentation/components/menu_drawer.dart';

class RetrievalPage extends StatefulWidget {
  const RetrievalPage({Key? key}) : super(key: key);

  @override
  State<RetrievalPage> createState() => _RetrievalViewState();
}

class _RetrievalViewState extends State<RetrievalPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> dataList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
  ];

  List<String> filteredList = [];
  String _selectedOption = 'All';

  @override
  void initState() {
    super.initState();
    // Copy the initial list to the filtered list
    filteredList.addAll(dataList);
  }

  void _handleOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieval - $_selectedOption'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleOptionSelected,
            itemBuilder: (BuildContext context) {
              return ['All', 'Customers', 'Rooms', 'Services']
                  .map((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: const MenuDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                // Filter the list based on the search input and selected option
                setState(() {
                  filteredList = dataList
                      .where((item) =>
                          item.toLowerCase().contains(value.toLowerCase()) &&
                          (_selectedOption == 'All' ||
                              item
                                  .toLowerCase()
                                  .contains(_selectedOption.toLowerCase())))
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
