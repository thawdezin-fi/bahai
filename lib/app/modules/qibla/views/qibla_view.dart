import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../controllers/qibla_controller.dart';

class QiblaView extends GetView<QiblaController> {
  const QiblaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final heading = controller.heading.value;
      final qiblah = controller.qiblahBearing.value;
      final score = controller.alignmentScore.value;
      final status = controller.locationStatus.value;
      final isLoading = controller.isLoading.value;

      final relativeAngle = (qiblah - heading + 360) % 360;

      // Dynamic background gradient
      // Dark grey to Light Green/Green based on alignment
      final bgColor1 = Color.lerp(const Color(0xFF1E1E1E), Colors.green.shade900, score) ?? const Color(0xFF1E1E1E);
      final bgColor2 = Color.lerp(const Color(0xFF121212), Colors.green.shade400, score) ?? const Color(0xFF121212);

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Qiblih Compass', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white), // Arrow အရောင်ကို အဖြူပေးထားပါတယ်
            onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [bgColor1, bgColor2],
            ),
          ),
          child: SafeArea(
            child: isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : status == null || (status != LocationPermission.always && status != LocationPermission.whileInUse)
                    ? _buildPermissionWarning()
                    : _buildCompass(relativeAngle, qiblah, score),
          ),
        ),
      );
    });
  }

  Widget _buildPermissionWarning() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off, size: 80, color: Colors.white54),
          const SizedBox(height: 20),
          const Text(
            'Location Permission Required',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Please enable location to find Qiblih.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => controller.requestPermission(),
            child: const Text('Grant Permission'),
          ),
        ],
      ),
    );
  }

  Widget _buildCompass(double relativeAngle, double qiblah, double score) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer Ring or Bahai Symbol as background
            Opacity(
              opacity: 0.8,
              child: Image.asset('assets/images/bahai.png', width: 280),
            ),
            // Compass Needle (Pin)
            AnimatedRotation(
              turns: (relativeAngle / 360.0), // Rotate towards Qibla relative to phone
              duration: const Duration(milliseconds: 200),
              child: Image.asset('assets/images/location-pin.png', width: 160),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Text(
          score > 0.9 ? 'Facing Qiblih' : 'Find the Qiblih',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            shadows: score > 0.9 ? [const Shadow(color: Colors.green, blurRadius: 20)] : [],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${(qiblah - controller.heading.value).abs() > 180 ? (360 - (qiblah - controller.heading.value).abs()).toStringAsFixed(1) : (qiblah - controller.heading.value).abs().toStringAsFixed(1)}° from Qiblih',
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

}