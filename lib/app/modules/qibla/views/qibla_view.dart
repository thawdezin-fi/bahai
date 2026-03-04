import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/qibla_controller.dart';

class QiblaView extends StatefulWidget {
  const QiblaView({super.key});

  @override
  State<QiblaView> createState() => _QiblaViewState();
}

class _QiblaViewState extends State<QiblaView> {
  late final QiblaController controller;
  late final TextEditingController latController;
  late final TextEditingController lngController;
  late final TextEditingController headingController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<QiblaController>();
    latController = TextEditingController(text: '16.8661');
    lngController = TextEditingController(text: '96.1951');
    headingController = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    latController.dispose();
    lngController.dispose();
    headingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Qiblih Direction')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Your location',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: latController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: lngController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: headingController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Current heading (0-360, optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: _calculateDirection,
                    icon: const Icon(Icons.explore),
                    label: const Text('Find Direction'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Obx(() {
            final result = controller.latestResult.value;
            if (result == null) {
              return const SizedBox.shrink();
            }

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Result',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _Row(
                      label: 'Bearing to Bahjí',
                      value: '${result.bearing.toStringAsFixed(1)}°',
                    ),
                    if (result.turnDegrees != null)
                      _Row(
                        label: 'Turn by',
                        value: '${result.turnDegrees!.toStringAsFixed(1)}°',
                      ),
                    if (result.turnInstruction != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(result.turnInstruction!),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _calculateDirection() {
    final lat = double.tryParse(latController.text.trim());
    final lng = double.tryParse(lngController.text.trim());
    final headingText = headingController.text.trim();
    final heading = headingText.isEmpty ? null : double.tryParse(headingText);

    if (lat == null || lng == null) {
      Get.snackbar(
        'Invalid input',
        'Please enter valid latitude and longitude.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (headingText.isNotEmpty && heading == null) {
      Get.snackbar(
        'Invalid heading',
        'Heading must be a number between 0 and 360.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    controller.calculateForInput(
      userLat: lat,
      userLng: lng,
      currentHeading: heading,
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;

  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
