import 'package:dio/dio.dart';
import 'package:gomechanic/models/directions_model.dart';
import 'package:gomechanic/utils/custom_snackbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
  static const String googleAPIKey = 'AIzaSyAqQPR76pnRoZgrURLM-HZAalkMv6Y0ufg';

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future getDirections({
    LatLng? origin,
    LatLng? destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin!.latitude},${origin.longitude}',
        'destination': '${destination!.latitude},${destination.longitude}',
        'key': googleAPIKey,
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return CustomAnimation().showCustomToast('error', isError: true);
  }
}