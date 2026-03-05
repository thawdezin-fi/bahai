import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/calendar_controller.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Dark background style
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('August 2026', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.chevron_left, color: Colors.white), onPressed: () {}),
          TextButton(onPressed: () {}, child: const Text('Today', style: TextStyle(color: Colors.white))),
          IconButton(icon: const Icon(Icons.chevron_right, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildWeekdayHeader(),
          const Divider(color: Colors.grey, height: 1),
          Expanded(
            child: Obx(() {
              final days = controller.daysInMonth;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 0.7, // Box shape ကို ချိန်ညှိဖို့
                ),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final date = days[index];
                  final badiInfo = controller.getBadiInfo(date);
                  final isCurrentMonth = date.month == 2026 && date.month == 8;

                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white12, width: 0.5),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            color: isCurrentMonth ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: Text(
                            badiInfo.monthName, // Baha'i Month Name
                            style: const TextStyle(color: Colors.cyan, fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Day ${badiInfo.day}', // Baha'i Day
                            style: const TextStyle(color: Colors.amber, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeader() {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      children: days.map((day) => Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(day, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ),
      )).toList(),
    );
  }
}