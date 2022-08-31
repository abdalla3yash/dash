
class AddressModel {
  late int? _id;
  late String? _addressType,
      _contentPersonName,
      _contentPersonNumber,
      _address,
      _latitude,
      _longitude;

  AddressModel({
    id,
    required addressType,
    contentPersonName,
    contentPersonNumber,
    address,
    latitude,
    longitude,
  }) {
    _id = id;
    _addressType = addressType;
    _contentPersonName = contentPersonName;
    _contentPersonNumber = contentPersonNumber;
    _longitude = longitude;
    _latitude = latitude;
  }
  String get address => address;
  String? get addressType => _addressType;
  String? get contentPersonName => _contentPersonName;
  String? get contentPersonNumber => _contentPersonNumber;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    _addressType = json["_address_type"] ?? "";
    _contentPersonName = json["content_person_name"] ?? "";
    _contentPersonNumber = json["content_person_number"] ?? "";
    _address = json["address"];
    _latitude = json["latitude"];
    _longitude = json["longitude"];
  }
}
