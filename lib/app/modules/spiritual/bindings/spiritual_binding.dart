import 'package:get/get.dart';

import '../controllers/spiritual_controller.dart';

class SpiritualBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpiritualController>(
      () => SpiritualController(),
    );
  }
}
