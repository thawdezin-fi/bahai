import 'package:get/get.dart';

import '../controllers/warm_glad_tidings_controller.dart';

class WarmGladTidingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WarmGladTidingsController>(
      () => WarmGladTidingsController(),
    );
  }
}
