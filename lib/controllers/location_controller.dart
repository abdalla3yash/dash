import 'package:dash/data/repository/location_repo.dart';
import 'package:dash/models/address_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _isLoading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressModel = [];
  late List<AddressModel> _allAddressList;
  List<String> _addressTypeList = ["home", "office", "others"];
  int _addressTypeIndex = 0;
}
