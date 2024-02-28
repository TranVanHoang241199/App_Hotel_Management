import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/presentation/components/menu_drawer.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticalPage extends StatefulWidget {
  const StatisticalPage({Key? key}) : super(key: key);

  @override
  State<StatisticalPage> createState() => _StatisticalPageState();
}

class _StatisticalPageState extends State<StatisticalPage> {
  bool _showRevenue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistical'),
      ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius:
                      80, // Đặt centerSpaceRadius thành một giá trị nhỏ hơn
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sections: _showRevenue
                      ? _getRevenueChartData()
                      : _getExpenseChartData(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ToggleButtons(
              children: const [
                Icon(Icons.trending_up),
                Icon(Icons.trending_down),
              ],
              isSelected: [_showRevenue, !_showRevenue],
              onPressed: (index) {
                setState(() {
                  _showRevenue = index == 0;
                });
              },
            ),
            SizedBox(height: 20),
            _showRevenue
                ? _buildDetails(_getRevenueDetails())
                : _buildDetails(_getExpenseDetails()),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getRevenueChartData() {
    // Thay thế dữ liệu này bằng dữ liệu thực tế của bạn
    return [
      PieChartSectionData(
        value: 40,
        color: Colors.green,
        title: 'Product A',
      ),
      PieChartSectionData(
        value: 30,
        color: Colors.blue,
        title: 'Product B',
      ),
      PieChartSectionData(
        value: 20,
        color: Colors.orange,
        title: 'Product C',
      ),
      PieChartSectionData(
        value: 10,
        color: Colors.red,
        title: 'Product D',
      ),
    ];
  }

  List<PieChartSectionData> _getExpenseChartData() {
    // Thay thế dữ liệu này bằng dữ liệu thực tế của bạn
    return [
      PieChartSectionData(
        value: 50,
        color: Colors.red,
        title: 'Expense A',
      ),
      PieChartSectionData(
        value: 25,
        color: Colors.yellow,
        title: 'Expense B',
      ),
      PieChartSectionData(
        value: 15,
        color: Colors.blue,
        title: 'Expense C',
      ),
      PieChartSectionData(
        value: 10,
        color: Colors.green,
        title: 'Expense D',
      ),
    ];
  }

  List<String> _getRevenueDetails() {
    // Thay thế dữ liệu này bằng dữ liệu thực tế của bạn
    return [
      'Product A Details',
      'Product B Details',
      'Product C Details',
      'Product D Details'
    ];
  }

  List<String> _getExpenseDetails() {
    // Thay thế dữ liệu này bằng dữ liệu thực tế của bạn
    return [
      'Expense A Details',
      'Expense B Details',
      'Expense C Details',
      'Expense D Details'
    ];
  }

  Widget _buildDetails(List<String> details) {
    return Column(
      children: details.map((detail) => ListTile(title: Text(detail))).toList(),
    );
  }
}
