import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String userName;
  final String phoneNumber;
  final String mealName;
  final String mealImage;
  final String mealDateTime;
  final String mealDetails;
  final String mealId;
  final double mealPrice;

  Order(
      {this.userName,
      this.phoneNumber,
      this.mealName,
      this.mealPrice,
      this.mealImage,
      this.mealDateTime,
      this.mealDetails,
      this.mealId});

  factory Order.fromFireStore(DocumentSnapshot doc) {
    // print('IN ORDER MODEL ${doc.data()}');
    Map data = doc.data();
    return Order(
      mealId: doc.id ?? 'NO ID',
      mealImage: data['meal_image'] ?? 'No image',
      mealName: data['meal_name'] ?? 'No name',
      userName: data['username'] ?? 'Unknown',
      phoneNumber: data['phone_number'] ?? 'Unknown',
      mealPrice: data['meal_price'] ?? 0,
      mealDetails: data['meal_details'] ?? 'بلا اضافات',
      mealDateTime: data['order_time'] ?? '',
    );
  }
}

// dynamic result = FirebaseFirestore.instance
//     .collection('$doc/user_orders')
//     .snapshots()
//     .map((snapshot) {
//   return snapshot.docs.map((doc) {
//     Map data = doc.data();
//     return Order(
//       mealName: data['meal_name'] ?? 'TEST SUCESS',
//       mealPrice: data['meal_price'] ?? 'SUCES AGAIN',
//     );
//   }).toList();
// });

// return result;
// print(result);
// Order itemTest(DocumentSnapshot doc) {
//   print('hi');
//   Map data = doc.data();
//   return Order(
//     mealName: data['meal_name'],
//   );
// }
//
// var test = doc.reference
//     .collection('user_orders')
//     .snapshots()
//     .map((snapshot) => snapshot.docs.map((data) => itemTest(data)))
//     .toList();
// print(test);
