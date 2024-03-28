import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/system_bloc/system.dart';
import '../../../data/models/service_model.dart';
import '../../widgets/error_dialog_widget.dart';
import '../../widgets/success_snackbar.dart';

class SystemServiceView extends StatelessWidget {
  SystemServiceView({super.key});
  // Controllers cho TextField và DropdownButton
  final _serviceNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceAmountController = TextEditingController();
  String? _selectedCategory;

  final _categories = ['', 'Category 1', 'Category 2', 'Category 3']; // Dan

  final msg = BlocBuilder<SystemBloc, SystemState>(builder: (context, state) {
    if (state is SystemServiceCreatetUpdateErrorState) {
      return ErrorDialog(message: state.message);
    } else if (state is SystemServiceDeleteErrorState) {
      return ErrorDialog(message: state.message);
    } else if (state is SystemServiceMessageSuccessState) {
      return SuccessSnackbar(message: state.message);
    } else {
      return Container();
    }
  });

  @override
  Widget build(BuildContext context) {
    final systemBloc = BlocProvider.of<SystemBloc>(context);
    systemBloc.add(SystemServiceStartEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text('Service System'),
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
                    systemBloc.add(SystemServiceStartEvent());
                  },
                  child: BlocBuilder<SystemBloc, SystemState>(
                      builder: (context, state) {
                    if (state is SystemServiceLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SystemServiceDataSuccessState) {
                      // Hiển thị danh sách phòng dưới dạng GridView
                      return _buildListService(state);
                    } else if (state is SystemServiceDataErrorState) {
                      return Center(
                        child: Text('Error: ${state.message}'),
                      );
                    } else if (state is SystemServiceNoDataState) {
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

  Widget _buildListService(state) {
    return ListView.builder(
      itemCount: state.listService.length,
      itemBuilder: (context, index) {
        ServiceModel Service = state.listService[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              'Name: ${Service.serviceName}\nFloor: ${Service.quantity}\nPrice: ${Service.priceAmount}',
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
                        .add(SystemServiceDeletePressedEvent(Service.id!));
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
            controller: _serviceNameController,
            decoration: const InputDecoration(labelText: 'Tên dịch vụ'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _quantityController,
            decoration: const InputDecoration(labelText: 'Số lượng'),
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
            controller: _priceAmountController,
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
              labelText: 'Loại dịch vụ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              ServiceModel serviceModel = ServiceModel(
                  serviceName: _serviceNameController.text,
                  quantity: int.tryParse(_quantityController.text) ?? 0,
                  priceAmount:
                      double.tryParse(_priceAmountController.text) ?? 0,
                  status: 0);
              print(serviceModel.toJson());
              systemBloc.add(SystemServiceCreatePressedEvent(serviceModel));

              _serviceNameController.clear();
              _quantityController.clear();
              _priceAmountController.clear();
            },
            child: Text('Thêm Phòng'),
          ),
        ),
      ],
    );
  }
}
