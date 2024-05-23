import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mepartments/src/pages/signup/sign_up_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Sign UP Page'),
      ),
    );
  }
}
