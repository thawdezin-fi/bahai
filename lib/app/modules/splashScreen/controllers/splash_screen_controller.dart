import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  Future<void> onReady() async {
    super.onReady();
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!isClosed) {
      Get.offAllNamed(Routes.HOME);
    }
  }
}
