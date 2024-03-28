import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_hotel_management/data/models/room_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/system_bloc/system.dart';
import '../../widgets/error_dialog_widget.dart';
import '../../widgets/success_snackbar.dart';

class SystemRoomView extends StatelessWidget {
  SystemRoomView({super.key});
  // Controllers cho TextField và DropdownButton
  final _nameController = TextEditingController();
  final _floorController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;

  final _categories = ['', 'Category 1', 'Category 2', 'Category 3']; // Dan

  final msg = BlocBuilder<SystemBloc, SystemState>(builder: (context, state) {
    if (state is SystemRoomCreatetUpdateErrorState) {
      return ErrorDialog(message: state.message);
    } else if (state is SystemRoomDeleteErrorState) {
      return ErrorDialog(message: state.message);
    } else if (state is SystemRoomMessageSuccessState) {
      return SuccessSnackbar(message: state.message);
    } else {
      return Container();
    }
  });

  @override
  Widget build(BuildContext context) {
    final systemBloc = BlocProvider.of<SystemBloc>(context);
    systemBloc.add(SystemRoomStartEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text('Room System'),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCreateUpdateFornt(systemBloc),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // Gửi sự kiện để load lại dữ liệu
                    systemBloc.add(SystemRoomStartEvent());
                  },
                  child: BlocBuilder<SystemBloc, SystemState>(
                      builder: (context, state) {
                    if (state is SystemRoomLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SystemRoomDataSuccessState) {
                      // Hiển thị danh sách phòng dưới dạng GridView
                      return _buildListRoom(state);
                    } else if (state is SystemRoomDataErrorState) {
                      return Center(
                        child: Text('Error: ${state.message}'),
                      );
                    } else if (state is SystemRoomNoDataState) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return Center(
                        child: Text('Lỗi khonogloading được'),
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
          msg,
        ],
      ),
    );
    ;
  }

  Widget _buildListRoom(state) {
    return ListView.builder(
      itemCount: state.listRoom.length,
      itemBuilder: (context, index) {
        RoomModel room = state.listRoom[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              'Name: ${room.roomName}\nFloor: ${room.floorNumber}\nPrice: ${room.priceAmount}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Xử lý sự kiện sửa phòng ở đây
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Xử lý sự kiện xoá danh mục phòng
                    BlocProvider.of<SystemBloc>(context)
                        .add(SystemRoomDeletePressedEvent(room.id!));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreateUpdateFornt(systemBloc) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Tên phòng'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _floorController,
            decoration: const InputDecoration(labelText: 'Tầng'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]')), // Chỉ cho phép nhập số
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _priceController,
            keyboardType: TextInputType.numberWithOptions(
                decimal: true), // Chỉ cho phép nhập số thập phân
            decoration: const InputDecoration(labelText: 'Giá'),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(
                  r'^\d+\.?\d{0,2}')), // Chỉ cho phép nhập số và tối đa 2 chữ số thập phân
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField(
            value: _selectedCategory,
            items: _categories.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              // setState(() {
              //   _selectedCategory = value as String?;
              // });
            },
            decoration: InputDecoration(
              labelText: 'Loại phòng',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              RoomModel roomModel = RoomModel(
                roomName: _nameController.text,
                floorNumber: int.tryParse(_floorController.text) ??
                    0, // Sử dụng int.tryParse để tránh lỗi nếu người dùng không nhập số
                priceAmount: double.tryParse(_priceController.text) ??
                    0, // Sử dụng double.tryParse để tránh lỗi nếu người dùng không nhập số
                status: 0,
              );
              print(roomModel.toJson());
              systemBloc.add(SystemRoomCreatePressedEvent(roomModel));

              _nameController.clear();
              _floorController.clear();
              _priceController.clear();
            },
            child: Text('Thêm Phòng'),
          ),
        ),
      ],
    );
  }
}
