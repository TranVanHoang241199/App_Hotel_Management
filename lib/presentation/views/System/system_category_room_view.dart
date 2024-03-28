import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/bloc/system_bloc/system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/error_dialog_widget.dart';
import '../../widgets/success_snackbar.dart';

class SystemCategoryRoomView extends StatelessWidget {
  SystemCategoryRoomView({super.key});

  final _txtNameCategoryRoom = TextEditingController();

  final msg = BlocBuilder<SystemBloc, SystemState>(builder: (context, state) {
    if (state is SystemCategoryRoomCreatetUpdateErrorState) {
      return ErrorDialog(message: state.message);
    } else if (state is SystemCategoryRoomDeleteErrorState) {
      return ErrorDialog(message: state.message);
    } else if (state is SystemCategoryRoomMessageSuccessState) {
      return SuccessSnackbar(message: state.message);
    } else {
      return Container();
    }
  });

  @override
  Widget build(BuildContext context) {
    // Controller cho TextField để lấy giá trị người dùng nhập
    final systemBloc = BlocProvider.of<SystemBloc>(context);
    systemBloc.add(SystemCategoryRoomStartEvent());

    _txtNameCategoryRoom.addListener(() {
      systemBloc.categoryRoomNameSink.add(_txtNameCategoryRoom.text);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Category Room System'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 15.0), // Đặt khoảng cách bên phải là 10.0
                        child: TextField(
                          controller: _txtNameCategoryRoom,
                          decoration: InputDecoration(
                            hintText: 'Enter category',
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final categoryName = _txtNameCategoryRoom.text;
                        systemBloc
                            .add(SystemCategoryRoomCreatePressed(categoryName));
                        _txtNameCategoryRoom.clear();
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // Gửi sự kiện để load lại dữ liệu
                    systemBloc.add(SystemCategoryRoomStartEvent());
                  },
                  child: BlocBuilder<SystemBloc, SystemState>(
                    builder: (context, state) {
                      if (state is SystemCategoryRoomLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SystemCategoryRoomDataSuccessState) {
                        // Hiển thị danh sách phòng dưới dạng GridView
                        return _buildListCategoryRoom(state);
                      } else if (state is SystemCategoryRoomDataErrorState) {
                        return Center(
                          child: Text('Error: ${state.message}'),
                        );
                      } else if (state is SystemCategoryRoomNoDataState) {
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
              ),
            ],
          ),
          msg,
        ],
      ),
    );
  }

  Widget _buildListCategoryRoom(state) {
    return ListView.builder(
      itemCount: state.listCategoryRoom.length,
      itemBuilder: (context, index) {
        final categoryRoom = state.listCategoryRoom[index];
        return ListTile(
          title: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(categoryRoom.categoryName),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Xử lý sự kiện sửa danh mục phòng
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Xử lý sự kiện xoá danh mục phòng
                  BlocProvider.of<SystemBloc>(context)
                      .add(SystemCategoryRoomDeletePressed(categoryRoom.id));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
