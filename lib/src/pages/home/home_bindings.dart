import 'package:get/get.dart';
import 'package:mepartments/src/pages/bills/bills_controller.dart';
import 'package:mepartments/src/pages/home/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<BillsController>(() => BillsController());
  }
}
