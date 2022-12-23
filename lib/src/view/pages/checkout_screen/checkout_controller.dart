import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CheckOutController extends GetxController {
  var address = 'Getting Address..'.obs;

  @override
  void onInit() async {
    super.onInit();
    getLocation();
  }

  @override
  void onClose() {}

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return await Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return await Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return await Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Geolocator.getCurrentPosition().then((value) {
      getAddressFromLatLang(value);
    });
  }

  Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: 'en');
    print(placeMark);
    Placemark place = placeMark[0];
    address.value =
        '${place.street} -- ${place.subLocality} -- ${place.locality} -- ${place.country}';
  }
}
