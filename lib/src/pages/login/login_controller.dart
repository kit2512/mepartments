import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mepartments/src/data/repositories/user_repository.dart';
import 'package:mepartments/src/pages/controllers/user_controllers.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final userController = Get.find<UserController>();
  final UserRepository userRepository = Get.find<UserRepository>();

  void login() async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (result.user == null) {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Password or username is incorrect, please try again',
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
      final user = await userRepository.getUser(result.user!.uid);
      userController.setUser(user);
      Get.offNamed('/home');
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'An error occurred, please try again',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
