import 'dart:async';

import 'package:get/get.dart';
import 'package:mepartments/src/data/models/bill.dart';
import 'package:mepartments/src/data/repositories/bills_repository.dart';
import 'package:mepartments/src/data/repositories/user_repository.dart';
import 'package:mepartments/src/pages/controllers/user_controllers.dart';

class BillsController extends GetxController {
  late final StreamSubscription<List<Bill>> _billSubscription;
  late final StreamSubscription<List<Bill>> _unpaidSubscription;
  late final StreamSubscription<List<Bill>> _paidSubscription;

  final RxList<Bill> _bills = <Bill>[].obs;

  List<Bill> get bills => _bills;

  List<Bill> get unPaidBills => _bills.where((bill) => bill.purchaseAt == null).toList();

  List<Bill> get paidBills => _bills.where((bill) => bill.purchaseAt != null).toList();

  final currentUser = Get.find<UserController>().user;
  final UserRepository userRepository = Get.find<UserRepository>();
  final BillRepository billsRepository = Get.find<BillRepository>();

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() {
    final userReference = Get.find<UserController>().currentUserReference!;
    _billSubscription = billsRepository.userAllBillsStream(userReference).listen((event) {
      _bills.value = event.toList();
    });
  }

  @override
  void onClose() {
    _billSubscription.cancel();
    _unpaidSubscription.cancel();
    _paidSubscription.cancel();
    super.onClose();
  }
}
