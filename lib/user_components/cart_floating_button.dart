import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/models/cart_meal.dart';
import 'package:resturant/views/user_pages/delivery_page.dart';
import 'package:resturant/views/user_pages/receipt_page.dart';

class CartFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalCartPrice = 0;
    final cartMeals = Provider.of<List<CartMeal>>(context);
    if (cartMeals != null)
      for (CartMeal cartMeal in cartMeals) {
        totalCartPrice += cartMeal.totalPrice;
      }
    print(totalCartPrice);

    return cartMeals == null
        ? Container()
        : cartMeals.isEmpty
            ? Container()
            : Container(
                width: double.infinity,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 45),
                  child: FloatingActionButton(
                    onPressed: () {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.info,
                          // autoCloseDuration: Duration(seconds: 10),

                          confirmBtnText: 'Receipt',
                          backgroundColor: Colors.deepOrange[400],
                          confirmBtnColor: Colors.deepOrange[400],
                          cancelBtnText: 'Delivery',
                          cancelBtnTextStyle: TextStyle(color: Colors.green),
                          onConfirmBtnTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReceiptPage(
                                    cartMeals: cartMeals,
                                  ),
                                ));
                          },
                          showCancelBtn: true,
                          onCancelBtnTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeliveryPage(
                                    cartMeal: cartMeals,
                                  ),
                                ));
                          });
                      // showDialog(
                      //   context: context,
                      //   builder: (context) {

                      // return AlertDialog(
                      //   title: const Text('Order Confirm'),
                      //   content: const Text('Choose way to pick order'),
                      //   actions: <Widget>[
                      //     TextButton(
                      //       child: const Text(
                      //         'Receipt',
                      //         style: TextStyle(
                      //           color: Colors.green,
                      //         ),
                      //       ),
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => ReceiptPage(
                      //                 cartMeals: cartMeals,
                      //               ),
                      //             ));
                      //       },
                      //     ),
                      //     ElevatedButton(
                      //       child: Text('Delivery'),
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => DeliveryPage(),
                      //             ));
                      //       },
                      //     )
                      //   ],
                      // );
                      //   },
                      // );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Confirm Order ",
                          style: TextStyle(fontSize: 23.5),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              'Total : ${totalCartPrice.toStringAsFixed(2)}',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    isExtended: true,
                  ),
                ),
              );
  }
}
