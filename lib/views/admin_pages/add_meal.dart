import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/category_list.dart';
import 'package:resturant/admin_components/get_image_button.dart';
import 'package:resturant/common_components/rounded_button.dart';
import 'file:///C:/Users/NTC/AndroidStudioProjects/resturant/lib/common_components/input_field.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/main.dart';
import 'package:resturant/models/category.dart';
import 'package:resturant/random_states.dart';
import 'package:resturant/views/admin_pages/image_picker.dart';
import 'package:resturant/views/user_pages/home_page.dart';

class AddMeal extends StatelessWidget {
  String url;
  File file;

  AddMeal({this.url, this.file});

  String mealName;
  String mealPrice;
  String mealDetails;
  String categoryName;
  var result;

  bool isOffer = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _goToImagePicker(context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ImageCapture()));
    // Scaffold.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text("$result")));
    // file = result;
    // print(file);
  }

  @override
  Widget build(BuildContext context) {
    print('Back $result');
    print('back $url');

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                file != null
                    ? Image.file(
                        file,
                        height: size.height * 0.3,
                      )
                    : TextButton(
                        child: Container(
                          height: size.height * 0.3,
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.deepOrange[400],
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute<String>(
                                  builder: (context) => ImageCapture()));
                          Scaffold.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text("$result")));
                          url = result;
                          print(url);
                        },
                      ),
                SizedBox(
                  height: 20,
                ),
                RoundedInputField(
                  validator: (String val) =>
                      val.isEmpty ? '???????? ?????? ????????????' : null,
                  hintText: '?????? ????????????',
                  icon: Icons.fastfood_outlined,
                  color: Colors.deepOrange,
                  onChanged: (val) {
                    mealName = val;
                  },
                ),
                RoundedInputField(
                  hintText: '????????????????',
                  validator: (String val) =>
                      val.isEmpty ? '???????? ???????????? ????????????' : null,
                  isMultiLine: true,
                  icon: Icons.line_style_sharp,
                  color: Colors.deepOrange,
                  onChanged: (val) {
                    mealDetails = val;
                  },
                ),
                RoundedInputField(
                  validator: (String val) =>
                      val.isEmpty ? '???????? ?????? ????????????' : null,
                  isNumber: true,
                  hintText: '??????????',
                  icon: Icons.monetization_on_outlined,
                  color: Colors.deepOrange,
                  onChanged: (val) {
                    mealPrice = val;
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: 220,
                  child: CategoryList(
                    isGroupButton: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 4, right: 4),
                  child: CheckboxListTile(
                    title: Text('Click to add to Offer list'),
                    activeColor: Colors.deepOrange,
                    checkColor: Colors.white,
                    value: Provider.of<RandomStates>(context).isOffer,
                    onChanged: (bool value) {
                      Provider.of<RandomStates>(context, listen: false)
                          .offerChoose(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 4, right: 4),
                  child: CheckboxListTile(
                    title: Text('Add to Additional list'),
                    activeColor: Colors.deepOrange,
                    checkColor: Colors.white,
                    value: Provider.of<RandomStates>(context).isAdditional,
                    onChanged: (bool value) {
                      Provider.of<RandomStates>(context, listen: false)
                          .additionalChoose(value);
                    },
                  ),
                ),
                RoundedButton(
                  text: '??????????',
                  color: Colors.deepOrange,
                  textColor: CupertinoColors.white,
                  press: () {
                    if (_formKey.currentState.validate()) {
                      print(
                          'OFFER ${Provider.of<RandomStates>(context, listen: false).isOffer}');
                      print(
                          'OFFER ${Provider.of<RandomStates>(context, listen: false).isAdditional}');

                      FireStoreService().addMeal(
                        mealImage: url,
                        mealName: mealName,
                        mealDetails: mealDetails,
                        mealPrice: double.parse(mealPrice),
                        categoryName:
                            Provider.of<RandomStates>(context, listen: false)
                                .categoryName,
                        isOffers:
                            Provider.of<RandomStates>(context, listen: false)
                                .isOffer,
                        isAdditional:
                            Provider.of<RandomStates>(context, listen: false)
                                .isAdditional,
                      );

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.symmetric(vertical: 10),
// child: Container(
// decoration: BoxDecoration(
// color: Colors.grey[300],
// borderRadius: BorderRadius.circular(25),
// ),
// child: SingleChildScrollView(
// physics: ScrollPhysics(),
// child: StreamBuilder(
// stream: FirebaseFirestore.instance
//     .collection('categories')
// .snapshots(),
// builder: FireStoreService().buildCategoryList,
// ),
// ),
// ),
// ),
