import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryHomeScreen extends StatefulWidget {
  const HistoryHomeScreen({Key? key}) : super(key: key);

  @override
  State<HistoryHomeScreen> createState() => _HistoryHomeScreenState();
}

class _HistoryHomeScreenState extends State<HistoryHomeScreen> {
  late DateTime _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List<HistoryModel>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    // Gọi hàm để lấy dữ liệu từ API và thêm vào _events
    _fetchDataAndPopulateEvents();
  }

  Future<void> _fetchDataAndPopulateEvents() async {
    // Gọi API để lấy dữ liệu, giả sử bạn sử dụng http package
    // Thay thế đoạn mã sau đây bằng cách gọi API thực tế của bạn
    final List<HistoryModel> historyModelList = await fetchDataFromApi();

    // Lưu trữ dữ liệu vào _events
    final Map<DateTime, List<HistoryModel>> newEvents = {};

    for (HistoryModel historyModel in historyModelList) {
      final DateTime eventDate = historyModel.date;
      newEvents[eventDate] ??= [];
      newEvents[eventDate]!.add(historyModel);
    }

    // Clear events for the selected day
    _events[_selectedDay.toUtc()]?.clear();

    // Add the new events to the selected day
    _events.addAll(newEvents);

    // Force rebuild widget khi có dữ liệu mới
    setState(() {});
  }

  // Giả sử hàm này gọi API để lấy dữ liệu, bạn cần thay thế nó bằng gọi API thực tế
  Future<List<HistoryModel>> fetchDataFromApi() async {
    // Đoạn mã giả định, thay thế nó bằng gọi API thực tế
    await Future.delayed(Duration(seconds: 2));

    // Giả sử dữ liệu trả về từ API có cấu trúc như sau
    return [
      HistoryModel(
        date: DateTime.utc(2024, 1, 31),
        roomName: 'Room 101',
        customerName: 'John Doe',
        phoneNumber: '123456789',
      ),
      HistoryModel(
        date: DateTime.utc(2024, 1, 31),
        roomName: 'Room 102',
        customerName: 'John ha',
        phoneNumber: '123456789',
      ),
      HistoryModel(
        date: DateTime.utc(2024, 2, 1),
        roomName: 'Room 102',
        customerName: 'Jane Doe',
        phoneNumber: '987654321',
      ),
      HistoryModel(
        date: DateTime.utc(2024, 2, 3),
        roomName: 'Room 103',
        customerName: 'Jane Doe',
        phoneNumber: '987654321',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          calendarFormat: _calendarFormat,
          firstDay: DateTime(2022, 1, 1, 0, 0, 0),
          lastDay: DateTime(2029, 12, 31, 23, 59, 59),
          focusedDay: _selectedDay,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
            _fetchDataAndPopulateEvents();
          },
          eventLoader: (day) {
            return _events[day] ?? [];
          },
          rowHeight: 35,
          headerStyle: HeaderStyle(
            titleCentered: true, // Đẩy text tháng ra giữa
            formatButtonVisible: false, // Tắt chọn dạng hiển thị tháng
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView(
            children: _buildEventsForSelectedDay(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildEventsForSelectedDay() {
    final eventsForSelectedDay = _events[_selectedDay.toUtc()];
    if (eventsForSelectedDay != null) {
      return eventsForSelectedDay
          .map((event) => Card(
                child: ListTile(
                  title: Text(
                      'Room: ${event.roomName}\nCustomer: ${event.customerName}\nPhone: ${event.phoneNumber}'),
                ),
              ))
          .toList();
    } else {
      return [
        ListTile(
          title: Text('Không có sự kiện cho ngày này'),
        ),
      ];
    }
  }
}

class HistoryModel {
  final DateTime date;
  final String roomName;
  final String customerName;
  final String phoneNumber;

  HistoryModel({
    required this.date,
    required this.roomName,
    required this.customerName,
    required this.phoneNumber,
  });
}
