import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/data/models/service_model.dart';
import 'package:flutter_app_hotel_management/utils/enum_help.dart';

class ServiceHomeView extends StatefulWidget {
  const ServiceHomeView({super.key});

  @override
  State<ServiceHomeView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ServiceHomeView> {
  List<ServiceModel> services = [];
  late GlobalKey<RefreshIndicatorState> _refreshKey;

  @override
  void initState() {
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    services = [
      ServiceModel(
          img:
              'https://scontent.fdad3-1.fna.fbcdn.net/v/t39.30808-1/274814333_980890775873828_6578552745804904053_n.jpg?stp=dst-jpg_p320x320&_nc_cat=110&ccb=1-7&_nc_sid=11e7ab&_nc_eui2=AeFLn0iTEOIwTjI3DsR21CoIqMolRiWC-GeoyiVGJYL4Zyq_ngx-9espvVkFQ4XRQuEnD4PlpcHkcbGvBF3XundL&_nc_ohc=LLz3N26xQNgAX9Auil4&_nc_ht=scontent.fdad3-1.fna&oh=00_AfDJ6XkpykpJzxya4GYj1XyCEIuWpricRupDItcEGgXizg&oe=65BB168C',
          serviceName: 'Banh trang trung',
          price: 10000,
          quantity: 10,
          status: EStatusService.active),
      ServiceModel(
          img:
              'https://scontent.fdad3-1.fna.fbcdn.net/v/t39.30808-1/274814333_980890775873828_6578552745804904053_n.jpg?stp=dst-jpg_p320x320&_nc_cat=110&ccb=1-7&_nc_sid=11e7ab&_nc_eui2=AeFLn0iTEOIwTjI3DsR21CoIqMolRiWC-GeoyiVGJYL4Zyq_ngx-9espvVkFQ4XRQuEnD4PlpcHkcbGvBF3XundL&_nc_ohc=LLz3N26xQNgAX9Auil4&_nc_ht=scontent.fdad3-1.fna&oh=00_AfDJ6XkpykpJzxya4GYj1XyCEIuWpricRupDItcEGgXizg&oe=65BB168C',
          serviceName: 'nuoc mia',
          price: 30000,
          quantity: 10,
          status: EStatusService.maintenance),
      ServiceModel(
          img:
              'https://scontent.fdad3-1.fna.fbcdn.net/v/t39.30808-1/274814333_980890775873828_6578552745804904053_n.jpg?stp=dst-jpg_p320x320&_nc_cat=110&ccb=1-7&_nc_sid=11e7ab&_nc_eui2=AeFLn0iTEOIwTjI3DsR21CoIqMolRiWC-GeoyiVGJYL4Zyq_ngx-9espvVkFQ4XRQuEnD4PlpcHkcbGvBF3XundL&_nc_ohc=LLz3N26xQNgAX9Auil4&_nc_ht=scontent.fdad3-1.fna&oh=00_AfDJ6XkpykpJzxya4GYj1XyCEIuWpricRupDItcEGgXizg&oe=65BB168C',
          serviceName: 'Sting',
          price: 20000,
          quantity: 10,
          status: EStatusService.end),
      ServiceModel(
          img:
              'https://scontent.fdad3-1.fna.fbcdn.net/v/t39.30808-1/274814333_980890775873828_6578552745804904053_n.jpg?stp=dst-jpg_p320x320&_nc_cat=110&ccb=1-7&_nc_sid=11e7ab&_nc_eui2=AeFLn0iTEOIwTjI3DsR21CoIqMolRiWC-GeoyiVGJYL4Zyq_ngx-9espvVkFQ4XRQuEnD4PlpcHkcbGvBF3XundL&_nc_ohc=LLz3N26xQNgAX9Auil4&_nc_ht=scontent.fdad3-1.fna&oh=00_AfDJ6XkpykpJzxya4GYj1XyCEIuWpricRupDItcEGgXizg&oe=65BB168C',
          serviceName: 'nuoc mia',
          price: 30000,
          quantity: 10,
          status: EStatusService.maintenance),
      // Add more services as needed
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: () async {
          // Implement your refresh logic here
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: getStatusColor(services[index].status),
                child: ListTile(
                  leading: Image.network(
                    services[index].img.toString(),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(services[index].serviceName.toString()),
                  subtitle: Text(services[index].price.toString()),
                  trailing: CircleAvatar(
                    backgroundColor: getStatusColor(services[index].status),
                    child: Icon(Icons.check),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Color getStatusColor(EStatusService status) {
    switch (status) {
      case EStatusService.active:
        return Colors.green;
      case EStatusService.end:
        return Colors.red;
      case EStatusService.maintenance:
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}
