import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mepartments/src/app_bindings.dart';
import 'package:mepartments/src/router.dart';

class MepartmentsApp extends StatelessWidget {
  const MepartmentsApp({
    super.key,
    required this.bindings,
  });

  final AppBindings bindings;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mepartments App',
      getPages: AppRouter.pages,
      initialRoute: AppRouter.splash,
      initialBinding: bindings,
    );
  }
}
