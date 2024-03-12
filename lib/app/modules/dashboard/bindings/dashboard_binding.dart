import 'package:get/get.dart';
import 'package:reyhan_flowbook/app/modules/explorer/controllers/explorer_controller.dart';
import 'package:reyhan_flowbook/app/modules/home/controllers/home_controller.dart';
import 'package:reyhan_flowbook/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<ExplorerController>(
          () => ExplorerController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}
