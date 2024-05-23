import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mepartments/src/pages/bills/bills_page.dart';
import 'package:mepartments/src/pages/home/home_controller.dart';
import 'package:mepartments/src/pages/news/news_page.dart';
import 'package:mepartments/src/router.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex,
          children: [
            const NewsPage(),
            const BillsPage(),
            Container(),
            ProfileScreen(
              actions: [
                SignedOutAction(
                  (context) => Get.offAllNamed(AppRouter.login),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: controller.onItemTapped,
          currentIndex: controller.selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment_rounded),
              label: 'Bills',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
