import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const _tabs = [
    _NavTab(
      label: 'Home',
      icon: Icons.home_outlined,
      title: 'Daily guidance',
      subtitle:
          'A starter hub for newcomers that highlights the Daily Bread, the 3 Pillars, quick introductions, and community news.',
      highlights: [
        'Daily Bread quote refreshed automatically.',
        'Interactive cards covering God, Religion, Humanity.',
        'Quick-start article: ဘဟာအီ ဆိုတာ ဘာလဲ?',
        'Latest global and local community updates.',
      ],
    ),
    _NavTab(
      label: 'Library',
      icon: Icons.menu_book_outlined,
      title: 'Learn and explore',
      subtitle:
          'Digital library that keeps beginner and deepening materials within one tap.',
      highlights: [
        'Beginner titles: Paris Talks, The New Era.',
        'Ultimate titles: The Hidden Words, Seven Valleys, Kitáb-i-Iqán.',
        'Search across English and Burmese.',
        'Bookmarking plus night mode for comfortable reading.',
      ],
    ),
    _NavTab(
      label: 'Spiritual',
      icon: Icons.self_improvement_outlined,
      title: 'Prayer & meditation',
      subtitle:
          'Organized prayers, audio recitations, and reminders for obligatory devotions.',
      highlights: [
        'Prayer categories for healing, protection, unity, and departed.',
        'Audio versions in Burmese and Persian.',
        'Obligatory prayers (Short, Medium, Long) with reminders.',
      ],
    ),
    _NavTab(
      label: 'Info',
      icon: Icons.settings_outlined,
      title: 'Tools for practice',
      subtitle:
          'Community-focused utilities: Badi calendar, support, and profile status.',
      highlights: [
        'Current Badi month, day, and upcoming Feasts.',
        'Q&A / Support contact for local institutions.',
        'Profile & reading progress tracking.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentTab = _tabs[controller.currentIndex.value];
      return Scaffold(
        appBar: AppBar(title: Text(currentTab.label), centerTitle: true),
        body: _TabBody(tab: currentTab),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
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

class _NavTab {
  final String label;
  final IconData icon;
  final String title;
  final String subtitle;
  final List<String> highlights;

  const _NavTab({
    required this.label,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.highlights,
  });
}

class _TabBody extends StatelessWidget {
  final _NavTab tab;

  const _TabBody({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(tab.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(tab.subtitle, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        ...tab.highlights.map((item) => _HighlightItem(text: item)),
      ],
    );
  }
}

class _HighlightItem extends StatelessWidget {
  final String text;

  const _HighlightItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
