import 'dart:async';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class QiblaController extends GetxController {

  // Bahjí (Shrine of Bahá'u'lláh) coordinates
  final qiblihLat = 32.943333;
  final qiblihLng = 35.091944;

  // Observable variables for UI updates
  final heading = 0.0.obs;
  final qiblahBearing = 0.0.obs;
  final alignmentScore = 0.0.obs;
  final locationStatus = Rxn<LocationPermission>();
  final isLoading = true.obs;

  StreamSubscription? _compassSubscription;
  StreamSubscription? _locationSubscription;

  @override
  void onInit() {
    super.onInit();
    _initSensors();
  }

  @override
  void onClose() {
    _compassSubscription?.cancel();
    _locationSubscription?.cancel();
    super.onClose();
  }

  Future<void> _initSensors() async {
    isLoading.value = true;
    LocationPermission permission = await Geolocator.checkPermission();
    locationStatus.value = permission;

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      _startTracking();
    } else {
      isLoading.value = false;
    }
  }

  void _startTracking() {
    isLoading.value = false;

    // Heading subscription
    _compassSubscription = FlutterCompass.events?.listen((event) {
      if (event.heading != null) {
        heading.value = event.heading!;
        _updateAlignment();
      }
    });

    // Location subscription
    _locationSubscription = Geolocator.getPositionStream().listen((position) {
      qiblahBearing.value = _calculateBearing(
        position.latitude,
        position.longitude,
        qiblihLat,
        qiblihLng,
      );
      _updateAlignment();
    });
  }

  void _updateAlignment() {
    // Relative angle: how many degrees to turn to face Qiblih
    double relativeAngle = (qiblahBearing.value - heading.value + 360) % 360;
    
    // Normalize to -180 to 180
    if (relativeAngle > 180) relativeAngle -= 360;

    final offset = relativeAngle.abs();
    if (offset < 5) {
      alignmentScore.value = 1.0;
    } else if (offset < 45) {
      alignmentScore.value = 0.5 + (0.5 * (1 - (offset - 5) / 40));
    } else {
      alignmentScore.value = 0.0;
    }
  }

  double _calculateBearing(double lat1, double lon1, double lat2, double lon2) {
    final phi1 = lat1 * math.pi / 180;
    final phi2 = lat2 * math.pi / 180;
    final deltaLambda = (lon2 - lon1) * math.pi / 180;

    final y = math.sin(deltaLambda) * math.cos(phi2);
    final x = math.cos(phi1) * math.sin(phi2) -
        math.sin(phi1) * math.cos(phi2) * math.cos(deltaLambda);

    return (math.atan2(y, x) * 180 / math.pi + 360) % 360;
  }

  Future<void> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    locationStatus.value = permission;
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      _startTracking();
    }
  }
}