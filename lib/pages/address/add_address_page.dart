import 'package:dash/controllers/auth_controller.dart';
import 'package:dash/controllers/location_controller.dart';
import 'package:dash/controllers/user_controller.dart';
import 'package:dash/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(30.0444, 31.2357), zoom: 17);

  late LatLng _initialPosition = const LatLng(30.0444, 31.2357);

  @override
  void initState() {
    super.initState();
    isLogged = Get.find<AuthController>().userLoggedIn();
    if (isLogged
        //  && Get.find<UserController>().userModel == null
        ) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["langitude"]),
        ),
      );
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["langitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Address Page"),
          backgroundColor: AppColors.mainColor,
        ),
        body: GetBuilder<LocationController>(
          builder: (locationController) {
            return Column(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Stack(children: [
                    GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: _initialPosition, zoom: 17),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: true,
                        onCameraIdle: () {
                          locationController.updatePosition(
                              _cameraPosition, true);
                        },
                        onCameraMove: (((position) =>
                            _cameraPosition = position)),
                        onMapCreated: (GoogleMapController controller) {
                          locationController.setMapController(controller);
                        }),
                  ]),
                ),
              ],
            );
          },
        ));
  }
}
