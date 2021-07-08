import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'models/order.dart';

class RandomStates extends ChangeNotifier {
  String categoryName;
  String logError = '';
  bool isOffer = false;
  bool isAdditional = false;
  bool loading = false;
  bool loading2 = true;

  int radioValue;
  int carsulCounter;

  void setCarsulCountervalue(int i) {
    carsulCounter = i;
    notifyListeners();
  }

  void getCategoryName(String newName) {
    categoryName = newName;
    notifyListeners();
  }

  void offerChoose(bool value) {
    isOffer = value;
    notifyListeners();
  }

  void additionalChoose(bool value) {
    isAdditional = value;
    notifyListeners();
  }

  void getRadioValue(int i) {
    radioValue = i;
    notifyListeners();
  }

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  void updateLogErrorMassage() {
    logError = 'ايميل غير صحيح';
    notifyListeners();
  }

  String getCurrentUser() {
    User logedInUser;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String uid;
    final user = _auth.currentUser;

    if (user != null) {
      logedInUser = user;

      uid = logedInUser.uid;

      return uid;
    }
    return 'No User';
  }
}
