import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/qibla_controller.dart';

class QiblaView extends GetView<QiblaController> {
  QiblaView({super.key});

  // UI Controllers
  final latController = TextEditingController(text: '16.8661');
  final lngController = TextEditingController(text: '96.1951');
  final headingController = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Qiblih Compass'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // --- Compass Visualizer ---
            Obx(() {
              final result = controller.latestResult.value;
              final heading = double.tryParse(headingController.text) ?? 0.0;
              final bearing = result?.bearing ?? 0.0;
              // 1 Turn = 360 degrees
              final rotationTurns = (bearing - heading) / 360.0;

              return Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/images/bahai.png', width: 260),
                      AnimatedRotation(
                        turns: rotationTurns,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutCubic,
                        child: Image.asset('assets/images/location-pin.png', width: 140),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (result != null) ...[
                    Text(
                      'Bearing: ${result.bearing.toStringAsFixed(1)}°',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(result.turnInstruction ?? '',
                        style: TextStyle(color: primaryColor, fontSize: 16)),
                  ]
                ],
              );
            }),

            const SizedBox(height: 30),

            // --- Input Section ---
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInput(latController, 'Latitude', Icons.location_on),
                    const SizedBox(height: 12),
                    _buildInput(lngController, 'Longitude', Icons.location_searching),
                    const SizedBox(height: 12),
                    _buildInput(headingController, 'Heading (Optional)', Icons.explore),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _onCalculate,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Calculate Direction'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController ctrl, String label, IconData icon) {
    return TextField(
      controller: ctrl,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  void _onCalculate() {
    final lat = double.tryParse(latController.text);
    final lng = double.tryParse(lngController.text);
    final heading = double.tryParse(headingController.text);

    if (lat != null && lng != null) {
      controller.calculateForInput(
        userLat: lat,
        userLng: lng,
        currentHeading: heading,
      );
    } else {
      Get.snackbar('Input Error', 'Please check your coordinates',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}