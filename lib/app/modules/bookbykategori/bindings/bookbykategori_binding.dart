import 'package:get/get.dart';

import '../controllers/bookbykategori_controller.dart';

class BookbykategoriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookbykategoriController>(
      () => BookbykategoriController(),
    );
  }
}
