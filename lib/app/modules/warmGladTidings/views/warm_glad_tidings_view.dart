import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/warm_glad_tidings_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/warm_glad_tidings_controller.dart';

class WarmGladTidingsView extends GetView<WarmGladTidingsController> {
  const WarmGladTidingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Dynamic AppBar
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color(0xFF1B5E20), // Deep Green for spiritual feel
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'ဝမ်းမြောက်ဖွယ်မင်္ဂလာသတင်း',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              centerTitle: true,
            ),
          ),

          // Content Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIntroSection(),
                  const Divider(height: 40, thickness: 1),
                  _buildHistorySection(),
                  const SizedBox(height: 30),
                  _buildPrinciplesSection(context),
                  const SizedBox(height: 40),
                  _buildFooterContact(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ၁။ အဖွင့်စာသား
  Widget _buildIntroSection() {
    return const Text(
      'ယနေ့ ကမ္ဘာတွင် ဗဟာအီသာသနာတော်သည် ကမ္ဘာ့အရှေ့ဖျားမှ အနောက်ဖျားသို့တိုင် အောင်မြင်စွာ ဖွဲ့စည်းတည်ထောင်ပြီးဖြစ်၍ ဤသာသနာတော်အကြောင်းကို အဆွေတော်တို့ ကြားသိလိုသောဆန္ဒ ရှိလိမ့်မည်ဟု ယုံကြည်မျှော်လင့်ပါသည်။',
      style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
    );
  }

  // ၂။ သမိုင်းစဉ် အကျဉ်းချုပ် (Card Style)
  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'သာသနာတော်၏ သမိုင်းစဉ် အကျဉ်းချုပ်',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
        ),
        const SizedBox(height: 15),
        const Text(
          'အတိတ်ကာလမှစ၍ ဘုရားရှင်များသည် တစ်ဆူပြီးတစ်ဆူ ကြွလာပွင့်တော်မူလျက် သာသနာသစ်ကို တည်ထောင်တော်မူကြသည့်နည်းတူ ယခုခေတ်အတွက် ဗဟာအုလ္လာဘုရားရှင်သည် ကြွလာပွင့်တော်မူခဲ့ပါသည်။',
          style: TextStyle(fontSize: 15, height: 1.6),
        ),
        const SizedBox(height: 15),
        // Quote Box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: const Border(left: BorderSide(color: Color(0xFF2E7D32), width: 4)),
          ),
          child: const Text(
            '“တောင်တမျှော်လင့်နေကြကုန်သော အို-အဆွေတို့၊ ဆိုင်းငံ့မနေကြကုန်လင့်၊ ဘုရားပွင့်တော်မူလေပြီ။”',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  // ၃။ ကမ္ဘာ့ဩဝါဒတရားတော်များ (List Style)
  Widget _buildPrinciplesSection(BuildContext context) {
    final principles = [
      'လူသားအားလုံးတို့ကို လူမျိုးတစ်မျိုးတည်းဟူ၍ အမှတ်ပြုရမည်။',
      'အမှန်တရားကို လွတ်လပ်သောစိတ်ဖြင့် ရှာဖွေကြရမည်။',
      'သာသနာအားလုံးတို့၏ မူလအခြေခံတရားသည် အတူတူပင် ဖြစ်သည်။',
      'သာသနာသည် လောကဓာတ်ပညာနှင့် ကျိုးကြောင်းလျော်ညီရမည်။',
      'သာသနာသည် လူသားအားလုံးတို့၏ ညီညွတ်ရေးအကြောင်းရင်း ဖြစ်စေရမည်။',
      'ယောက်ျားနှင့် မိန်းမ အဆင့်အတန်း မခွဲခြားဘဲ တန်းတူအခွင့်အရေး ရရှိစေရမည်။',
      'အယူသီးမှု၊ အမြင်ကျဉ်းမှုတို့ကို ပယ်ဖျက်ပစ်ကြရမည်။',
      'ကမ္ဘာ့ငြိမ်းချမ်းရေးအတွက် လူအပေါင်းတို့ ကြိုးစားလုပ်ဆောင်ကြရမည်။',
      'မသင်မနေရ ပညာရေးစနစ်ကို ဖန်တီးတည်ထောင်ရမည်။',
      'စီးပွားရေးပြဿနာကို လောကုတ္တရာနည်းဖြင့် ဖြေရှင်းရမည်။',
      'တစ်ကမ္ဘာလုံးတွင် အသုံးပြုနိုင်သည့် ဘာသာစကားတစ်မျိုး ထားရှိရမည်။',
      'ကမ္ဘာ့အဖွဲ့ချုပ်ကြီးတစ်ခုကို ဖွဲ့စည်းတည်ထောင်ရမည်။',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ကမ္ဘာ့ဩဝါဒတရားတော်များ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
        ),
        const SizedBox(height: 15),
        ...principles.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: const Color(0xFF2E7D32),
                  child: Text('${entry.key + 1}', style: const TextStyle(fontSize: 12, color: Colors.white)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  // ၄။ အောက်ခြေ ဆက်သွယ်ရန် (Footer)
  Widget _buildFooterContact() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Text(
            'နိုင်ငံလုံးဆိုင်ရာ ဗဟာအီသာသနာအဖွဲ့ချုပ်',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'အမှတ်(၃၅၅)၊ ဗညားဒလလမ်း၊ တာမွေမြို့နယ်၊ ရန်ကုန်မြို့။',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.phone, size: 18, color: Colors.green),
              const SizedBox(width: 8),
              const Text('01-556764, 09-799556764'),
            ],
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            onPressed: () {}, // Email link logic
            icon: const Icon(Icons.email, size: 18),
            label: const Text('nsa.myanmar@gmail.com'),
          ),
        ],
      ),
    );
  }
}