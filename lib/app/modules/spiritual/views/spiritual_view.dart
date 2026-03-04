import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/spiritual_controller.dart';

class SpiritualView extends GetView<SpiritualController> {
  const SpiritualView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpiritualView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SpiritualView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
