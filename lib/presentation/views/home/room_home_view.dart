import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_app_hotel_management/utils/helps/help_widgets.dart';
import 'package:flutter_app_hotel_management/presentation/widgets/room_item_widget.dart';

class RoomHomeView extends StatefulWidget {
  const RoomHomeView({Key? key}) : super(key: key);

  @override
  _RoomHomeScreenState createState() => _RoomHomeScreenState();
}

class _RoomHomeScreenState extends State<RoomHomeView> {
  late HomeBloC _homeBloC;
  late GlobalKey<RefreshIndicatorState> _refreshKey;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _homeBloC = HomeBloC();
    _homeBloC.selectedItems = [];
    _homeBloC.roomData = [];
    _homeBloC.search = '';
    _homeBloC.currentPage = 1;
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    _scrollController = ScrollController();
    fetchData();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> fetchData() async {
    try {
      final response =
          await _homeBloC.getAllRooms(_homeBloC.search, _homeBloC.currentPage);

      if (response.status == 200) {
        setState(() {
          _homeBloC.roomData = response.data ?? [];
          _homeBloC.selectedItems =
              List.generate(_homeBloC.roomData.length, (index) => false);
        });
      } else {
        HelpWidgets.showErrorDialog(
          context,
          'Error: ${response.message}',
          onRetry: fetchData,
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  /**
   * Load them trang
   */
  Future<void> _loadMoreData() async {
    try {
      final response = await _homeBloC.getAllRooms(
          _homeBloC.search, _homeBloC.currentPage + 1);

      if (response.status == 200) {
        setState(() {
          _homeBloC.roomData.addAll(response.data ?? []);
          _homeBloC.selectedItems.addAll(
            List.generate(response.data!.length, (index) => false),
          );
          _homeBloC.currentPage++; // Increase the page number for the next load
        });
      } else {
        // ignore: use_build_context_synchronously
        HelpWidgets.showErrorDialog(
          context,
          'Error: ${response.message}',
          onRetry: _loadMoreData,
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // Reached the end of the list
      _loadMoreData(); // Load more data
    }
  }

  void _toggleSelectedItem(int index) {
    setState(() {
      _homeBloC.selectedItems[index] = !_homeBloC.selectedItems[index];
    });
  }

  void _handleItemDoubleTap(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Thông tin chi tiết"),
          content: const Text("Đặt phòng, mua phòng, thuê phòng"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Đóng"),
            ),
          ],
        );
      },
    );
  }

  void _handleItemLongPress(int index, BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _getLongPressRect(index, overlay),
        Offset.zero & overlay.size,
      ),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: Text('Đặt phòng'),
          onTap: () {
            Navigator.pop(context); // Close the menu
            _showDialog('Đặt phòng');
          },
        ),
        PopupMenuItem(
          child: Text('Mua phòng'),
          onTap: () {
            Navigator.pop(context); // Close the menu
            _showDialog('Mua phòng');
          },
        ),
        PopupMenuItem(
          child: Text('Thuê phòng'),
          onTap: () {
            Navigator.pop(context); // Close the menu
            _showDialog('Thuê phòng');
          },
        ),
      ],
    );
  }

  void _showDialog(String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thông tin chi tiết"),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Đóng"),
            ),
          ],
        );
      },
    );
  }

  Rect _getLongPressRect(int index, RenderBox overlay) {
    final RenderBox itemBox = context.findRenderObject() as RenderBox;
    final Offset itemPosition =
        itemBox.localToGlobal(Offset.zero, ancestor: overlay);
    const double itemWidth = 150.0; // Width of the long-press area
    const double itemHeight = 50.0; // Height of the long-press area

    return Rect.fromPoints(
      itemPosition,
      itemPosition.translate(itemWidth, itemHeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: () async {
          _homeBloC.currentPage = 1;
          await fetchData();
        },
        child: _homeBloC.roomData.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                controller: _scrollController,
                itemCount: _homeBloC.roomData.length,
                itemBuilder: (BuildContext context, int index) {
                  return RoomItemWidget(
                    room: _homeBloC.roomData[index],
                    selected: _homeBloC.selectedItems[index],
                    onTap: () => _toggleSelectedItem(index),
                    onDoubleTap: () => _handleItemDoubleTap(index),
                    onLongPress: () => _handleItemLongPress(index, context),
                  );
                },
              ),
      ),
    );
  }
}
