import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/library_controller.dart';

class LibraryView extends GetView<LibraryController> {
  const LibraryView({super.key});

  static const _monthChips = [
    'Month 1: Bahá (ရောင်ခြည်တော်)',
    'Month 18: Mulk (အုပ်စိုးမှု)',
    'Intercalary Days: Ayyám-i-Há (ပျော်ရွှင်ခြင်း)',
    'Month 19: ‘Alá’ (မြင့်မြတ်ခြင်း)',
  ];

  static const _calendarSteps = [
    '၁၉ လ၊ ၁၉ ရက် (၃၆၁ ရက် စုစုပေါင်း) အတွင်း နေဝင်ချိန်အရ Ayyám-i-Há အပါအဝင် တိကျတဲ့ အချိန်तालင်းကို ထိန်းသိမ်းပါ။',
    'March 20/21 (Naw-Rúz) မှ စပြီး နေဝင်ချိန်ကိုထား၍ ရက်ပေါင်းများကို ၁၉ နဲ့ ခွဲစိတ်ဆောင်ပါ။',
    'Leap နေသည့် နှစ်တွင် Ayyám-i-Há သည် ၅ ရက်ဖြစ်ပြီး မဟုတ်ရင် ၄ ရက်သာ ပါဝင်သည်။',
  ];

  static const _directionTips = [
    'ကိဗ်လာ Bahjí, Israel (32.9433° N, 35.0919° E) ကို ရှာဖွေရန် Great Circle Bearing formula ကို အသုံးပြုပါ။',
    'Phone ကို Flat ထားရန်၊ GPS & Compass permission ကို ခွင့်ပြုရန်၊ Calibration ပြုလုပ်ရန် သတိပေးပါ။',
    'Result ကို တိုက်ရိုက် ကြည့်နိုင်ရန် Compass widget အတွင်း Bahá\'u\'lláh စိန် (logo) ကို သတ်မှတ်၍ အချိန်ပြန်ပြပါ။',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant.withOpacity(0.2),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _CalendarCard(
                    primary: colorScheme.primary,
                    accent: colorScheme.secondary,
                    onDetailTap: () => _showCalendarDetail(context),
                  ),
                  const SizedBox(height: 12),
                  _DirectionCard(
                    primary: colorScheme.primary,
                    accent: colorScheme.secondary,
                    onDetailTap: () => _showDirectionDetail(context),
                  ),
                ]),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 30)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.menu_book_rounded, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ဉာဏ်အလင်း Library', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 6),
                Text(
                  'Calendar နှင့် Qiblih တို့ကို စူးစမ်းဖို့ လမ်းပြအဆင့်အသစ်',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Icon(Icons.auto_stories_rounded, color: theme.colorScheme.primary),
        ],
      ),
    );
  }

  void _showCalendarDetail(BuildContext context) {
    final theme = Theme.of(context);
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text('ပြက္ခဒိန် Logic', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 10),
              ..._calendarSteps
                  .map(
                    (step) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(fontSize: 20)),
                          Expanded(
                            child: Text(
                              step,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: _monthChips
                    .map(
                      (label) => Chip(
                        label: Text(label),
                        backgroundColor: theme.colorScheme.primary.withOpacity(
                          0.15,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 18),
              Text('Pseudo-Code', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const SelectableText('''
void getBadiDate(DateTime gregorianDate, double latitude, double longitude) {
  final sunsetTime = calculateSunset(gregorianDate, latitude, longitude);
  if (gregorianDate.isAfter(sunsetTime)) {
    gregorianDate = gregorianDate.add(Duration(days: 1));
  }
  final daysSinceNawRuz = calculateDaysSinceNawRuz(gregorianDate);
  // 1. Use daysSinceNawRuz to derive month/day via 19-cycle.
  // 2. Handle Ayyám-i-Há as an intercalary block based on leap year check.
}''', style: TextStyle(fontFamily: 'monospace', height: 1.4)),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('လက်ရှိပြက္ခဒိန်အချက်အလက်အား ပိတ်ရန်'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDirectionDetail(BuildContext context) {
    final theme = Theme.of(context);
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Qiblih Bearing Logic',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              ..._directionTips
                  .map(
                    (tip) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(fontSize: 20)),
                          Expanded(
                            child: Text(tip, style: theme.textTheme.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              const SizedBox(height: 12),
              _CompassIndicator(heading: 142),
              const SizedBox(height: 14),
              Text('Direction Formula', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const SelectableText('''
import 'dart:math' as math;

class QiblihService {
  static const qiblihLat = 32.9433;
  static const qiblihLong = 35.0919;

  double calculateQiblihDirection(double userLat, double userLong) {
    final phi1 = userLat * (math.pi / 180.0);
    final lambda1 = userLong * (math.pi / 180.0);
    final phi2 = qiblihLat * (math.pi / 180.0);
    final lambda2 = qiblihLong * (math.pi / 180.0);

    final deltaLambda = lambda2 - lambda1;
    final y = math.sin(deltaLambda) * math.cos(phi2);
    final x = math.cos(phi1) * math.sin(phi2) -
        math.sin(phi1) * math.cos(phi2) * math.cos(deltaLambda);

    final bearing = math.atan2(y, x);
    return (bearing * (180.0 / math.pi) + 360) % 360;
  }
}
''', style: TextStyle(fontFamily: 'monospace', height: 1.4)),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Direction Detail ပိတ်ရန်'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalendarCard extends StatelessWidget {
  final Color primary;
  final Color accent;
  final VoidCallback onDetailTap;

  const _CalendarCard({
    super.key,
    required this.primary,
    required this.accent,
    required this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: accent.withOpacity(0.12),
                  child: Icon(Icons.calendar_month, color: accent),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ပြက္ခဒိန်၏ အခြေခံတည်ဆောက်ပုံ',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'The 19-19-4/5 structure that guards Naw-Rúz, Ayyám-i-Há, and the sunset boundary.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primary.withOpacity(0.15),
                  ),
                  child: Text(
                    'Calendar',
                    style: theme.textTheme.labelSmall?.copyWith(color: primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: LibraryView._monthChips
                  .map(
                    (chip) => Chip(
                      label: Text(chip),
                      backgroundColor: Colors.white,
                      labelStyle: theme.textTheme.bodySmall,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            ...LibraryView._calendarSteps.map(
              (step) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(step, style: theme.textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onDetailTap,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Calendar ကို ဆက်လက်ကြည့်ရှုရန်'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DirectionCard extends StatelessWidget {
  final Color primary;
  final Color accent;
  final VoidCallback onDetailTap;

  const _DirectionCard({
    super.key,
    required this.primary,
    required this.accent,
    required this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: accent.withOpacity(0.12),
                  child: Icon(Icons.explore, color: accent),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ဘဟာအီ ကိဗ်လာ (Qiblih Direction)',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Use the compass, bearing math, and Bahá\'u\'lláh’s Shrine coordinates to face the right way.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primary.withOpacity(0.15),
                  ),
                  child: Text(
                    'Direction',
                    style: theme.textTheme.labelSmall?.copyWith(color: primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _CompassIndicator(heading: 142),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: LibraryView._directionTips
                        .take(3)
                        .map(
                          (tip) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(tip, style: theme.textTheme.bodyMedium),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onDetailTap,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Direction ကို တိကျအောင် ထပ်မံကြည့်ရန်'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompassIndicator extends StatelessWidget {
  final double heading;

  const _CompassIndicator({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    final size = 96.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (var i = 0; i < 360; i += 30)
            Positioned(
              top: (size / 2) - 2,
              left: size / 2 - 1,
              child: Transform.rotate(
                angle: math.pi * 2 * (i / 360),
                child: Container(
                  width: 2,
                  height: 6,
                  color: i % 90 == 0 ? Colors.black87 : Colors.black26,
                ),
              ),
            ),
          Transform.rotate(
            angle: heading * (math.pi / 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 4,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 4,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 6,
            child: Text('142°', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
