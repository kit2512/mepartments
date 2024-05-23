import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mepartments/src/data/repositories/user_repository.dart';
import 'package:mepartments/src/pages/controllers/user_controllers.dart';
import 'package:mepartments/src/router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  final UserRepository userRepository = Get.find<UserRepository>();

  Future<void> getUser() async {
    await Future.delayed(const Duration(seconds: 2));
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        final user = await userRepository.getUser(FirebaseAuth.instance.currentUser!.uid);
        Get.find<UserController>().setUser(user);
        Get.offNamed(AppRouter.home);
      } catch (e) {
        Get.offNamed(AppRouter.login);
      }
    } else {
      Get.offNamed(AppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text('Splash'),
        ),
      );
}
