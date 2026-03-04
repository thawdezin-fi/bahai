import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/calendar_controller.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Baha’i Calendar')),
      body: Obx(() {
        final now = controller.now.value;
        final badi = controller.badiNow;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _Row(label: 'Gregorian', value: _dateTimeLabel(now)),
                    _Row(label: 'Badi year', value: badi.year.toString()),
                    _Row(label: 'Month', value: badi.monthName),
                    _Row(label: 'Day', value: badi.day.toString()),
                    if (badi.isAyyamiHa)
                      const _Row(label: 'Special', value: 'Ayyám-i-Há'),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: controller.refreshNow,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Logic used',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('• Naw-Rúz baseline is March 20.'),
                    const Text('• 19 months × 19 days = 361 days.'),
                    const Text('• Ayyám-i-Há fills 4 or 5 intercalary days.'),
                    const Text(
                      '• Date switches after sunset (approximated at 6:00 PM).',
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  String _dateTimeLabel(DateTime dateTime) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year} '
        '$hour:$minute';
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
            width: 110,
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
