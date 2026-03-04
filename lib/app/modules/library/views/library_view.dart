import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/library_controller.dart';

class LibraryView extends GetView<LibraryController> {
  const LibraryView({super.key});

  static final _features = [
    _LibraryFeature(
      title: 'ပြက္ခဒိန်၏ အခြေခံတည်ဆောက်ပုံ',
      subtitle:
          'The 19-19-4/5 rule that defines the rhythm of the Badi Calendar and how Leap and Intercalary days are inserted.',
      icon: Icons.calendar_month_outlined,
      badge: 'Calendar Logic',
      highlights: [
        '၁ နှစ်မှာ ၁၉ လ၊ ၁ လမှာ ၁၉ ရက် (၃၆၁ ရက် စုစုပေါင်း။)',
        'နေရောင်ပေါင်းစုစုပေါင်း ၃၆၅ / ၃၆၆ ရက်ကို Ayyám-i-Há (Intercalary Days) နဲ့ ဖြည့်တင်း။',
        'Ayyám-i-Há ကို Bahá\'í နိုင်ငံက ၁၈ လနှင့် ၁၉ လ အကြား ထည့်သွင်းပြီး နေဝင်ချိန်အလိုက် အချိန်တာဝန်ယူ။',
      ],
      notes: [
        '(က) Naw-Rúz သတ်မှတ်ချက် သည် Vernal Equinox (March 20/21) သို့မဟုတ် သတ်မှတ်ထားသော နေရာအလိုက် တွက်ချက်။',
        '(ခ) Gregorian Leap Year ကို အခြေခံပြီး Ayyám-i-Há ကို Leap အတွက် ၄ သို့မဟုတ် ၅ ရက်တွင် ချိန်ညှိ။',
        '(ဂ) Sunset-based start time မူတည်ပြီး နေဝင်ချိန်စနစ်အတွက် GPS ကိရိယာများအသုံးပြုသည်။',
      ],
      codeSnippet: '''
void getBadiDate(DateTime gregorianDate, double latitude, double longitude) {
  final sunsetTime = calculateSunset(gregorianDate, latitude, longitude);
  if (gregorianDate.isAfter(sunsetTime)) {
    gregorianDate = gregorianDate.add(Duration(days: 1));
  }

  final daysSinceNawRuz = calculateDaysSinceNawRuz(gregorianDate);
  // Use ၁၉ to derive month/day, handle Ayyám-i-Há as special case.
}
''',
    ),
    _LibraryFeature(
      title: 'ဘဟာအီ ကိဗ်လာ (Qiblih Direction)',
      subtitle:
          'A compass-inspired helper that guides the believer toward the Shrine of Bahá\'u\'lláh from anywhere.',
      icon: Icons.explore_outlined,
      badge: 'Direction & Bearing',
      highlights: [
        'Location: Bahjí, near Akka, Israel (32.9433° N, 35.0919° E).',
        'Daily obligatory prayers require facing this Shrine.',
        'Compass interface sings with gentle accuracy hints and calibration cues.',
      ],
      notes: [
        'Use absolute bearing formula: θ=atan2(sin(Δλ)⋅cos(ϕ₂), cos(ϕ₁)⋅sin(ϕ₂) - sin(ϕ₁)⋅cos(ϕ₂)⋅cos(Δλ)).',
        'Δλ = λ₂ - λ₁ (Qiblih minus user longitude); convert degrees to radians before trigonometry.',
        'Remind user to keep the phone flat, grant location permission, and verify Magnetometer calibration.',
      ],
      codeSnippet: '''
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
''',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant.withOpacity(0.3),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.book_outlined, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ဉာဏ်အလင်း Library',
                            style: theme.textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'အချစ်တရားကို နက်နဲစွာ နားလည်ဖို့ နေ့စဉ်လေ့လာမှု အစီအစဉ်',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: colorScheme.primary),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final feature = _features[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: _LibraryFeatureCard(
                      feature: feature,
                      accent: colorScheme.secondary,
                    ),
                  );
                }, childCount: _features.length),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
          ],
        ),
      ),
    );
  }
}

class _LibraryFeature {
  final String title;
  final String subtitle;
  final IconData icon;
  final String badge;
  final List<String> highlights;
  final List<String> notes;
  final String codeSnippet;

  const _LibraryFeature({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.badge,
    required this.highlights,
    required this.notes,
    required this.codeSnippet,
  });
}

class _LibraryFeatureCard extends StatelessWidget {
  final _LibraryFeature feature;
  final Color accent;

  const _LibraryFeatureCard({
    super.key,
    required this.feature,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: accent.withOpacity(0.15),
                  child: Icon(feature.icon, color: accent, size: 26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature.title,
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(feature.subtitle, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    feature.badge,
                    style:
                        theme.textTheme.labelSmall?.copyWith(
                          color: accent,
                          fontWeight: FontWeight.bold,
                        ) ??
                        TextStyle(color: accent, fontSize: 12),
                  ),
                ),
              ],
            ),
            const Divider(height: 28),
            ...feature.highlights.map(
              (highlight) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.chevron_right, size: 18, color: accent),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(highlight, style: theme.textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...feature.notes.map(
              (note) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('•', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(note, style: theme.textTheme.bodySmall),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                feature.codeSnippet.trim(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
