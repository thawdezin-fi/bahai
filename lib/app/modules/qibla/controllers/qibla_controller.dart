import 'dart:math' as math;
import 'package:get/get.dart';

class QiblaController extends GetxController {
  static const qiblihLat = 32.9433;
  static const qiblihLng = 35.0919;

  final latestResult = Rxn<QiblaResult>();

  @override
  void onInit() {
    super.onInit();
    latestResult.value = calculateDirection(
      userLat: 16.8661,
      userLng: 96.1951,
      currentHeading: 0,
    );
  }

  QiblaResult calculateDirection({
    required double userLat,
    required double userLng,
    double? currentHeading,
  }) {
    final phi1 = _toRadians(userLat);
    final lambda1 = _toRadians(userLng);
    final phi2 = _toRadians(qiblihLat);
    final lambda2 = _toRadians(qiblihLng);

    final deltaLambda = lambda2 - lambda1;
    final y = math.sin(deltaLambda) * math.cos(phi2);
    final x =
        math.cos(phi1) * math.sin(phi2) -
        math.sin(phi1) * math.cos(phi2) * math.cos(deltaLambda);
    final bearing = (_toDegrees(math.atan2(y, x)) + 360) % 360;

    double? turnDegrees;
    String? turnInstruction;

    if (currentHeading != null) {
      turnDegrees = (bearing - currentHeading + 540) % 360 - 180;
      final delta = turnDegrees.abs();
      if (delta < 5) {
        turnInstruction = 'You are already facing close to Qiblih.';
      } else if (turnDegrees > 0) {
        turnInstruction = 'Turn right by ${delta.toStringAsFixed(1)}°.';
      } else {
        turnInstruction = 'Turn left by ${delta.toStringAsFixed(1)}°.';
      }
    }

    return QiblaResult(
      bearing: bearing,
      turnDegrees: turnDegrees,
      turnInstruction: turnInstruction,
    );
  }

  void calculateForInput({
    required double userLat,
    required double userLng,
    double? currentHeading,
  }) {
    latestResult.value = calculateDirection(
      userLat: userLat,
      userLng: userLng,
      currentHeading: currentHeading,
    );
  }

  double _toRadians(double value) => value * (math.pi / 180.0);

  double _toDegrees(double value) => value * (180.0 / math.pi);
}

class QiblaResult {
  final double bearing;
  final double? turnDegrees;
  final String? turnInstruction;

  const QiblaResult({
    required this.bearing,
    required this.turnDegrees,
    required this.turnInstruction,
  });
}
