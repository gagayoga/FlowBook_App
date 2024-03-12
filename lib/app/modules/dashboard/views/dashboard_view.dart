import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reyhan_flowbook/components/customBottomBar.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Text(
          'DashboardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        controller: controller.changeTabIndex,
        //controllerIndex: controller.tabIndex,
      ),
    );
  }
}
