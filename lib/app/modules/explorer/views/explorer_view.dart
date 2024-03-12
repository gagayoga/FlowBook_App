import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/explorer_controller.dart';

class ExplorerView extends GetView<ExplorerController> {
  const ExplorerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExplorerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ExplorerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
