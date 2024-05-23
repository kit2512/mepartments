import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mepartments/src/data/models/bill.dart';

class BillRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Bill>> userAllBillsStream(DocumentReference userRef) =>
      _firestore.collection('bills').where('paidBy', isEqualTo: userRef).orderBy('dueDate').snapshots().map(
            (snapshot) => snapshot.docs.map((doc) => Bill.fromData(id: doc.id, data: doc.data())).toList(),
          );

  Future<void> payBill(DocumentReference billRef) async {}

  Future<void> updateBill(DocumentReference billRef, Map<String, dynamic> data) async {
    await billRef.update(data);
  }

  Future<String> createPurchaseUrl(Bill bill) async {
    return '';
  }
}
