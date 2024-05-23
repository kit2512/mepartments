import 'package:cloud_firestore/cloud_firestore.dart';

class Bill {
  final String id;
  final int amount;
  final String unit;
  final BillType type;
  final Timestamp dueDate;
  final DocumentReference paidBy;
  final DocumentReference createdBy;
  final Timestamp? purchaseAt;
  final int unitPrice;

  const Bill({
    required this.id,
    required this.amount,
    required this.unit,
    required this.type,
    required this.dueDate,
    required this.paidBy,
    required this.createdBy,
    this.purchaseAt,
    required this.unitPrice,
  });

  factory Bill.fromData({required String id, required Map<String, dynamic> data}) {
    return Bill(
      id: id,
      amount: data['amount'],
      unit: data['unit'],
      type: BillType.values.byName(data['type']),
      dueDate: data['dueDate'],
      paidBy: data['paidBy'],
      createdBy: data['createdBy'],
      purchaseAt: data['purchaseAt'],
      unitPrice: data['unitPrice'],
    );
  }

  bool get isPaid => purchaseAt != null;
}

enum BillType {
  electricity,
  water,
  gas,
  internet,
  phone,
  other,
}
