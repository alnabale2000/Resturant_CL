import 'package:flutter/material.dart';
import 'package:resturant/models/cart_meal.dart';

class DeliveryPage extends StatelessWidget {
  final List<CartMeal> cartMeal;

  DeliveryPage({this.cartMeal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('DeliveryPage'),
      ),
    );
  }
}
