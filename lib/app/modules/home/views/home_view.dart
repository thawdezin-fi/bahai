import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../library/views/library_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const _tabs = [
    _NavTab(label: 'Home', icon: Icons.home_outlined),
    _NavTab(label: 'Library', icon: Icons.menu_book_outlined),
    _NavTab(label: 'Spiritual', icon: Icons.self_improvement_outlined),
    _NavTab(label: 'Info', icon: Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final index = controller.currentIndex.value;
      return Scaffold(
        appBar: AppBar(title: Text(_tabs[index].label), centerTitle: true),
        body: IndexedStack(
          index: index,
          children: const [
            _SimpleTab(
              title: 'Welcome',
              body: 'Open the Library tab to use Calendar and Qiblih tools.',
              icon: Icons.lightbulb_outline,
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: LibraryTabContent(),
              ),
            ),
            _SimpleTab(
              title: 'Spiritual',
              body: 'Prayer and devotional features can be connected here.',
              icon: Icons.volunteer_activism_outlined,
            ),
            _SimpleTab(
              title: 'Info',
              body: 'App settings and support details can be shown here.',
              icon: Icons.info_outline,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: controller.changeTab,
          type: BottomNavigationBarType.fixed,
          items: _tabs
              .map(
                (tab) => BottomNavigationBarItem(
                  icon: Icon(tab.icon),
                  label: tab.label,
                ),
              )
              .toList(),
        ),
      );
    });
  }
}

class _SimpleTab extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;

  const _SimpleTab({
    required this.title,
    required this.body,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(body, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _NavTab {
  final String label;
  final IconData icon;

  const _NavTab({required this.label, required this.icon});
}
