library my_prj.globals;

import 'package:resturant/firebase/firestore.dart';

String userCheck = '';
String userId;

void setAdminValue(String isAdmin) {
  userCheck = isAdmin;
}

void setId(String id) {
  userId = id;
}

// Future<dynamic> adminCheck() async {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   User logedInUser;
//
//   String uid;
//
//   try {
//     final user = _auth.currentUser;
//
//     if (user != null) logedInUser = user;
//
//     uid = logedInUser.uid;
//
//     var userData =
//         await FirebaseFirestore.instance.collection('users').doc(uid).get();
//     // setState(() {
//     //   isAdmin = userData.data()['admin'];
//     // });
//     return userData;
//   } catch (e) {
//     print('failed');
//   }
// }
