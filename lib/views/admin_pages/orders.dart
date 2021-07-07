import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/orders_list.dart';
import 'package:resturant/firebase/firestore.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: FireStoreService().orders,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: OrdersList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          child: Icon(
            Icons.replay,
            color: Colors.white,
          ),
          onPressed: () {
            FireStoreService().deleteAllAdminOrders();
          },
        ),
      ),
    );
  }
}
