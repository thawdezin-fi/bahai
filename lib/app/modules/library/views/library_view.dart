import 'package:bahai/app/modules/calendar/views/calendar_view.dart';
import 'package:bahai/app/modules/qibla/views/qibla_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: LibraryTabContent(),
        ),
      ),
    );
  }
}

class LibraryTabContent extends StatelessWidget {
  const LibraryTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Library Tools', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          'Open one of the two tools below.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () => Get.toNamed(Routes.CALENDAR),
          icon: const Icon(Icons.calendar_month_outlined),
          label: const Text('Calendar'),
        ),
        const SizedBox(height: 12),
        FilledButton.tonalIcon(
          onPressed: () => Get.toNamed(Routes.QIBLA),
          icon: const Icon(Icons.explore_outlined),
          label: const Text('Qibla'),
        ),
        const SizedBox(height: 12),
        FilledButton.tonalIcon(
          onPressed: () => Get.toNamed(Routes.INFO),
          icon: const Icon(Icons.info),
          label: const Text('Info'),
        ),
        const SizedBox(height: 12),
        FilledButton.tonalIcon(
          onPressed: () => Get.toNamed(Routes.WARM_GLAD_TIDINGS),
          icon: const Icon(Icons.face),
          label: const Text('Glad Tidings'),
        ),
      ],
    );
  }
}
