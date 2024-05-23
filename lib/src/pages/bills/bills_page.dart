import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mepartments/src/pages/bills/bills_controller.dart';

class BillsPage extends GetView<BillsController> {
  const BillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bills'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Unpaid Bills',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.red,
                      ),
                ),
                SizedBox(
                  height: 150,
                  child: Obx(
                    () => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final bill = controller.unPaidBills[index];
                        return SizedBox(
                          width: 250,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(bill.type.toString()),
                                  Text(bill.amount.toString()),
                                  Text(bill.dueDate.toDate().toString()),
                                  Text(bill.unitPrice.toString()),
                                  Text(bill.unit.toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemCount: controller.unPaidBills.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Paid Bills',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.red,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Obx(
                      () {
                        if (controller.paidBills.isEmpty) {
                          return const Center(
                            child: Text('No paid bills'),
                          );
                        }
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            final bill = controller.paidBills[index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bill.type.toString()),
                                    Text(bill.amount.toString()),
                                    Text(bill.dueDate.toString()),
                                    Text(bill.purchaseAt.toString()),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemCount: controller.paidBills.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
