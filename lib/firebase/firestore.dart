import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:resturant/models/cart_meal.dart';
import 'package:resturant/models/category.dart';
import 'package:resturant/models/meal.dart';
import 'package:resturant/models/order.dart';

class FireStoreService extends ChangeNotifier {
  final String catNameFromProvider;
  final String userId;

  FireStoreService({this.catNameFromProvider, this.userId});

  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference categoryMeals =
      FirebaseFirestore.instance.collection('meals');

  final CollectionReference offersCollection =
      FirebaseFirestore.instance.collection('offers');

  final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('orders');

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference additionalMealsCollection =
      FirebaseFirestore.instance.collection('additional');

  ///
  // void setOfferCollection() {
  //   categoriesCollection.doc('Offers').update({'category_name': 'Offers'});
  // }
  ///
  //  ---------------------------------START ADD SECTION------------------------------------------------

  void addCategory(String image, String categoryName) async {
    await categoriesCollection
        .doc(categoryName)
        .set({'image_url': image, 'category_name': categoryName});
  }

  void addMeal({
    String mealImage,
    String mealName,
    double mealPrice,
    String categoryName,
    String mealDetails,
    bool isOffers = false,
    bool isAdditional = false,
  }) {
    categoryName == null
        ? null
        : categoriesCollection
            .doc(categoryName)
            .collection('meals')
            .doc(mealName)
            .set(
            {
              'meal_name': mealName,
              'meal_image': mealImage,
              'meal_price': mealPrice,
              'meal_details': mealDetails,
            },
          );
    isOffers
        ? categoriesCollection
            .doc('Offers')
            .collection('meals')
            .doc(mealName)
            .set(
            {
              'meal_name': mealName,
              'meal_image': mealImage,
              'meal_price': mealPrice,
              'meal_details': mealDetails,
            },
          )
        : null;
    isAdditional
        ? additionalMealsCollection.doc(mealName).set({
            'meal_name': mealName,
            'meal_image': mealImage,
            'meal_price': mealPrice,
            'meal_details': mealDetails,
          })
        : null;
  }

  void addToUserCart({
    String uid,
    String mealName,
    double mealPrice,
    String mealDetails,
    String mealImage,
    int count,
    double totalPrice,
  }) {
    usersCollection.doc(uid).collection('user_orders').doc(mealName).set({
      'meal_name': mealName,
      'meal_price': mealPrice,
      'meal_details': mealDetails,
      'meal_image': mealImage,
      'count': count,
      'total_price': totalPrice,
    });
  }

  void addOrder({
    mealId,
    String mealImage,
    String mealName,
    String userName,
    String userId,
    int phoneNumber,
    int mealCount,
    double mealPrice,
    double totalPrice,
    String mealDetails,
  }) {
    var time = DateTime.now().toString();
    print(userId);

    ordersCollection.add({
      'order_time': time,
      'meal_name': mealName,
      'meal_details': mealDetails,
      'meal_image': mealImage,
      'username': userName,
      'phone_number': phoneNumber,
      'meal_price': mealPrice,
      'meal_count': mealCount,
      'total_price': totalPrice,
      'user_id': userId,
    });
  }

  void editCount({String uid, int count, String mealName, double totalPrice}) {
    if (count >= 1)
      usersCollection
          .doc(uid)
          .collection('user_orders')
          .doc(mealName)
          .update({'count': count, 'total_price': totalPrice});
    else
      count = 1;
  }

  /*

  void add (String test,list){
  'meal_additional': map

  }
   */
  //  ------------------------------------END ADD SECTION---------------------------------------------

  //  ------------------------------------START GET SECTION-------------------------------------------

  /// START GET ORDER

  List<Order> _orderList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Order.fromFireStore(doc)).toList();
  }

  Stream<List<Order>> get orders {
    return ordersCollection
        .orderBy('order_time', descending: false)
        .snapshots()
        .map(_orderList);
  }

  List<Meal> _additionalList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Meal.fromFireStore(doc)).toList();
  }

  Stream<List<Meal>> get additionalMeals {
    return additionalMealsCollection.snapshots().map(_additionalList);
  }

  /// END GET ORDER

  /// START GET category
  List<Category> _categoryList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Category.fromFireStore(doc)).toList();
  }

  Stream<List<Category>> get categories {
    return categoriesCollection.snapshots().map(_categoryList);
  }

  /// END GET category

  /// START GET meal
  List<Meal> _mealList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Meal.fromFireStore(doc)).toList();
  }

  Stream<List<Meal>> get meals {
    return categoriesCollection
        .doc(catNameFromProvider)
        .collection('meals')
        .snapshots()
        .map(_mealList);
  }

  List<CartMeal> _cartMealList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => CartMeal.fromFireStore(doc)).toList();
  }

  Stream<List<CartMeal>> get cartMeals {
    return usersCollection
        .doc(userId)
        .collection('user_orders')
        .snapshots()
        .map(_cartMealList);
  }

  /// END GET meal
  //  ------------------------------------END GET SECTION------------------------------------------------

  //  ------------------------------------START DELETE SECTION-------------------------------------------

  void deleteAllAdminOrders() async {
    dynamic snapshot = await ordersCollection.get();
    for (DocumentSnapshot documentSnapshot in snapshot.docs)
      documentSnapshot.reference.delete();
  }

  void deleteSingleOrderDocument({String userId}) async {
    dynamic snapshot =
        await ordersCollection.where('user_id', isEqualTo: userId).get();
    for (DocumentSnapshot documentSnapshot in snapshot.docs)
      documentSnapshot.reference.delete();

    //await ordersCollection.doc(orderId).delete();
  }

  void deleteAllCartMeals({String uid}) async {
    dynamic snapshot =
        await usersCollection.doc(uid).collection('user_orders').get();
    for (DocumentSnapshot documentSnapshot in snapshot.docs) {
      documentSnapshot.reference.delete();
    }
  }

  void deleteSingleCartMealDoc({String uid, String mealName}) async {
    await usersCollection
        .doc(uid)
        .collection('user_orders')
        .doc(mealName)
        .delete();
  }

  void deleteSingleMealDocument(
      {String mealName, String collectionName}) async {
    await categoriesCollection
        .doc(collectionName)
        .collection('meals')
        .doc(mealName)
        .delete();

    await categoriesCollection
        .doc('Offers')
        .collection('meals')
        .doc(mealName)
        .delete();
  }

  void deleteSingleCategoryDocument({String categoryName}) async {
    await categoriesCollection.doc(categoryName).delete();
  }

  //  ------------------------------------END DELETE SECTION-------------------------------------------

  // -------------------------------------START USER SECTION-------------------------------------------

  Future updateUserData(
    String username,
    String email,
    String uid,
  ) async {
    return await usersCollection.doc(uid).set({
      'username': username,
      'email': email,
      'admin': 'false',
    });
  }

  printId(QueryDocumentSnapshot<Object> e) {
    print(e);
  }
}
