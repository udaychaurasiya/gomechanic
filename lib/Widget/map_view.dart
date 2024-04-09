import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class MapViewWidget extends StatefulWidget {
  const MapViewWidget({Key? key}) : super(key: key);

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}
class _MapViewWidgetState extends State<MapViewWidget> {
  final LoginController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
          center: LatLong(26.882285, 80.912967),
          hintText: 'Search your location',
          zoomInIcon: Icons.add,
          zoomOutIcon: Icons.remove,
          onPicked: (pickedData) {
            if (kDebugMode) {
              print(pickedData.latLong.latitude);
              print(pickedData.latLong.longitude);
              print(pickedData.address);
            }
            controller.Address.value = pickedData.address.toString();
            Get.back();
          }),
    );
  }
}