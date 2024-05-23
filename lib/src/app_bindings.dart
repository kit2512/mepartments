import 'package:get/get.dart';
import 'package:mepartments/src/data/repositories/bills_repository.dart';
import 'package:mepartments/src/data/repositories/post_repositories.dart';
import 'package:mepartments/src/data/repositories/user_repository.dart';
import 'package:mepartments/src/pages/controllers/user_controllers.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PostRepository());
    Get.put(UserController());
    Get.put(UserRepository());
    Get.put(BillRepository());
  }
}
