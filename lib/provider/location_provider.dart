import 'dart:js';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kwik/utils/showSnackbar.dart';

class LocationProvider extends ChangeNotifier {
  String? _currentAddress;
  Position? _currentPosition;

  String get currentAddress => _currentAddress!;
  Position get currentPosition => _currentPosition!;

  //handleLocationPermission

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(context,
          'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar(context, 'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar(context,
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  //get current location

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();

  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     _currentPosition = position;
  //     _getAddressFromLatLng(_currentPosition!);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });

  //   Future<void> _getAddressFromLatLng(Position position) async {
  //     await placemarkFromCoordinates(
  //             _currentPosition!.latitude, _currentPosition!.longitude)
  //         .then((List<Placemark> placemarks) {
  //       Placemark place = placemarks[0];
  //       _currentAddress =
  //           '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
  //     }).catchError((e) {
  //       debugPrint(e);
  //     });
  //   }
  // }
}
