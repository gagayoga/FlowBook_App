import 'package:get/get.dart';

import '../controllers/buktipeminjaman_controller.dart';

class BuktipeminjamanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuktipeminjamanController>(
      () => BuktipeminjamanController(),
    );
  }
}
