import 'package:flutter/material.dart';
import 'package:flutter_app_hotel_management/data/models/room_model.dart';

class RoomItemWidget extends StatelessWidget {
  final RoomModel room;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final VoidCallback onLongPress;

  const RoomItemWidget({
    required this.room,
    required this.selected,
    required this.onTap,
    required this.onDoubleTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: Card(
        elevation: 3.0,
        color: selected ? Colors.blue[100] : null,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    room.roomName ?? '...',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(
                  height: 8.0,
                  thickness: 1.0,
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("tang ${room.floorNumber}"),
                        Text(room.priceAmount.toString(),
                            style: TextStyle(fontSize: 10.0)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getStatusColor(room.status ?? 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getStatusColor(int param) {
    switch (param) {
      case 0:
        return Colors.green.withOpacity(0.7); // Adjust the opacity as needed
      case 1:
        return Colors.yellow.withOpacity(0.7);
      case 2:
        return Colors.red.withOpacity(0.7);
      case 3:
        return Colors.white.withOpacity(0.7);
      default:
        return Colors.black.withOpacity(0.7);
    }
  }
}
