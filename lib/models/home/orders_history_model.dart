import 'package:flutter/material.dart';

abstract class OrdersHistoryModel extends ChangeNotifier {
  // fetchCustomerOrders();
}

class OrdersHistoryModelImpl extends OrdersHistoryModel {
  // @override
  // Future<List<Map<String, dynamic>>> fetchCustomerOrders(BuildContext context) async {

  //   try {
  //     final QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('orders')
  //         .where('customerId', isEqualTo: )
  //         .orderBy('orderDate', descending: true) // Latest first
  //         .get();

  //     return snapshot.docs.map((doc) {
  //       return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
  //     }).toList();
  //   } catch (e) {
  //     print('Error fetching customer orders: $e');
  //     return [];
  //   }
  // }
}
