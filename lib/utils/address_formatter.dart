import 'package:geocoding/geocoding.dart';

String formatAddress(Placemark place) {
  return [
    place.subLocality,
    place.locality,
    place.administrativeArea,
  ].where((element) => element != null && element.isNotEmpty).join(', ');
} 