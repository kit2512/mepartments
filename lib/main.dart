import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mepartments/src/app.dart';
import 'package:mepartments/src/app_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appBindings = AppBindings();
  appBindings.dependencies();
  runApp(MepartmentsApp(
    bindings: appBindings,
  ));
}
