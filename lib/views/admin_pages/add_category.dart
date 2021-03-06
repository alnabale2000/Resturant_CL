import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resturant/admin_components/get_image_button.dart';
import 'file:///C:/Users/NTC/AndroidStudioProjects/resturant/lib/common_components/input_field.dart';
import 'package:resturant/firebase/firestore.dart';

import 'image_picker.dart';

class AddCategory extends StatelessWidget {
  String url;
  File file;
  final TabController tabController;

  AddCategory({this.url, this.file, this.tabController});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String categoryName;

  _goToImagePicker(context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ImageCapture()));
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
    file = result;
    print(file);
  }

  @override
  Widget build(BuildContext context) {
    print('test2');
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ///Start The top small box
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: size.width / 2.5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.greenAccent[400],
                    ),
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.adjust_sharp,
                      color: Colors.deepOrange[400],
                    ),
                    // child: Image.network(
                    //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcof3pIm8ZLI0NMZKT7T47CuANQmWvSzd8EA&usqp=CAU',
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),

                ///End The top small box

                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: Center(
                    child: ListView(
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
                                onPressed: () {
                                  _goToImagePicker(context);
                                }),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        RoundedInputField(
                          validator: (String val) =>
                              val.isEmpty ? '?????? ?????????? ??????????' : null,
                          backGroundColor: Colors.white,
                          color: Colors.deepOrange[400],
                          icon: Icons.list_alt,
                          hintText: '?????? ??????????',
                          onChanged: (val) {
                            categoryName = val;
                          },
                        ),
                        SizedBox(height: size.height * 0.07),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                FireStoreService()
                                    .addCategory(url, categoryName);
                                tabController.animateTo(1);

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => AddMeal()));
                              }
                            },
                            child: Text(
                              '??????????',
                              style: TextStyle(
                                  color: Colors.deepOrange[400],
                                  fontSize: 20,
                                  fontFamily: 'Pacifico'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
