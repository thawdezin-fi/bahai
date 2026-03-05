import 'package:get/get.dart';

class CalendarController extends GetxController {
  static const monthNames = [
    'Bahá',
    'Jalál',
    'Jamál',
    '‘Aẓamat',
    'Núr',
    'Raḥmat',
    'Kalimát',
    'Kamál',
    'Asmá’',
    '‘Izzat',
    'Mashíyyat',
    '‘Ilm',
    'Qudrat',
    'Qawl',
    'Masá’il',
    'Sharaf',
    'Sulṭán',
    'Mulk',
    '‘Alá’',
  ];

  final selectedMonth = DateTime(DateTime.now().year, DateTime.now().month, 1).obs;

  List<DateTime> get daysInMonth {
    final firstDay = DateTime(selectedMonth.value.year, selectedMonth.value.month, 1);
    final lastDay = DateTime(selectedMonth.value.year, selectedMonth.value.month + 1, 0);

    // Grid မှာ နေရာမှန်ဖို့အတွက် ရှေ့က လအဟောင်းရဲ့ ရက်တွေကို padding ထည့်ပေးရမယ် (e.g. Sunday ကနေ စဖို့)
    final firstDayOffset = firstDay.weekday % 7;
    final startCalendarDate = firstDay.subtract(Duration(days: firstDayOffset));

    // စုစုပေါင်း ၄၂ ကွက် (6 rows * 7 days) logic သုံးပါမယ်
    return List.generate(42, (index) => startCalendarDate.add(Duration(days: index)));
  }

  void nextMonth() {
    selectedMonth.value = DateTime(selectedMonth.value.year, selectedMonth.value.month + 1, 1);
  }

  void previousMonth() {
    selectedMonth.value = DateTime(selectedMonth.value.year, selectedMonth.value.month - 1, 1);
  }

  // ရှင့်ရဲ့ calculateBadiDate function ကို ဒီနေရာမှာ ပြန်သုံးထားပါတယ်ရှင့်
  BadiDateInfo getBadiInfo(DateTime date) => calculateBadiDate(date);

  final now = DateTime.now().obs;

  BadiDateInfo get badiNow => calculateBadiDate(now.value);

  void refreshNow() => now.value = DateTime.now();

  BadiDateInfo calculateBadiDate(DateTime dateTime, {int sunsetHour = 18}) {
    final local = dateTime.toLocal();
    var effectiveDate = DateTime(local.year, local.month, local.day);
    if (local.hour >= sunsetHour) {
      effectiveDate = effectiveDate.add(const Duration(days: 1));
    }

    final thisNawRuz = DateTime(effectiveDate.year, 3, 20);
    final badiYearStart = effectiveDate.isBefore(thisNawRuz)
        ? DateTime(effectiveDate.year - 1, 3, 20)
        : thisNawRuz;

    final nextBadiYearStart = DateTime(badiYearStart.year + 1, 3, 20);
    final intercalaryDays =
        nextBadiYearStart.difference(badiYearStart).inDays - 361;
    final dayOfBadiYear = effectiveDate.difference(badiYearStart).inDays + 1;
    final beforeAyyamiHaLength = 18 * 19;
    final badiYear = badiYearStart.year - 1843;

    if (dayOfBadiYear <= beforeAyyamiHaLength) {
      final monthNumber = ((dayOfBadiYear - 1) ~/ 19) + 1;
      final day = ((dayOfBadiYear - 1) % 19) + 1;
      return BadiDateInfo(
        year: badiYear,
        monthNumber: monthNumber,
        monthName: monthNames[monthNumber - 1],
        day: day,
        isAyyamiHa: false,
      );
    }

    if (dayOfBadiYear <= beforeAyyamiHaLength + intercalaryDays) {
      return BadiDateInfo(
        year: badiYear,
        monthNumber: null,
        monthName: 'Ayyám-i-Há',
        day: dayOfBadiYear - beforeAyyamiHaLength,
        isAyyamiHa: true,
      );
    }

    return BadiDateInfo(
      year: badiYear,
      monthNumber: 19,
      monthName: monthNames[18],
      day: dayOfBadiYear - (beforeAyyamiHaLength + intercalaryDays),
      isAyyamiHa: false,
    );
  }
}

class BadiDateInfo {
  final int year;
  final int? monthNumber;
  final String monthName;
  final int day;
  final bool isAyyamiHa;

  const BadiDateInfo({
    required this.year,
    required this.monthNumber,
    required this.monthName,
    required this.day,
    required this.isAyyamiHa,
  });
}
