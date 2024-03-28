import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/bloc/system_bloc/system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/error_dialog_widget.dart';
import '../../widgets/success_snackbar.dart';

class SystemCategoryServiceView extends StatelessWidget {
  SystemCategoryServiceView({super.key});

  final _txtNameCategoryService = TextEditingController();

  final msg = BlocBuilder<SystemBloc, SystemState>(builder: (context, state) {
    if (state is SystemCategoryServiceCreatetUpdateErrorState) {
      return ErrorDialog(message: state.message);
    } else if (state is SystemCategoryServiceDeleteErrorState) {
      return ErrorDialog(message: state.message);
    } else if (state is SystemCategoryServiceMessageSuccessState) {
      return SuccessSnackbar(message: state.message);
    } else {
      return Container();
    }
  });

  @override
  Widget build(BuildContext context) {
    // Controller cho TextField để lấy giá trị người dùng nhập
    final systemBloc = BlocProvider.of<SystemBloc>(context);
    systemBloc.add(SystemCategoryServiceStartEvent());

    _txtNameCategoryService.addListener(() {
      systemBloc.categoryServiceNameSink.add(_txtNameCategoryService.text);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Category Service System'),
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
                          controller: _txtNameCategoryService,
                          decoration: InputDecoration(
                            hintText: 'Enter category',
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final categoryName = _txtNameCategoryService.text;
                        systemBloc.add(
                            SystemCategoryServiceCreatePressed(categoryName));
                        _txtNameCategoryService.clear();
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
                    systemBloc.add(SystemCategoryServiceStartEvent());
                  },
                  child: BlocBuilder<SystemBloc, SystemState>(
                    builder: (context, state) {
                      if (state is SystemCategoryServiceLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state
                          is SystemCategoryServiceDataSuccessState) {
                        // Hiển thị danh sách phòng dưới dạng GridView
                        return _buildListCategoryService(state);
                      } else if (state is SystemCategoryServiceDataErrorState) {
                        return Center(
                          child: Text('Error: ${state.message}'),
                        );
                      } else if (state is SystemCategoryServiceNoDataState) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Center(
                          child: Text('Lỗi khonogloading được'),
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

  Widget _buildListCategoryService(state) {
    return ListView.builder(
      itemCount: state.listCategoryService.length,
      itemBuilder: (context, index) {
        final categoryService = state.listCategoryService[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(categoryService.categoryName),
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
                    BlocProvider.of<SystemBloc>(context).add(
                        SystemCategoryServiceDeletePressed(categoryService.id));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
