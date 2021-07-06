import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant/languages/language_data.dart';
import 'package:resturant/languages/languages.dart';
import 'package:resturant/languages/locale_constant.dart';

class LanguagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LanguagePageState();
}

class LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_sharp,
          color: Colors.deepOrange[300],
        ),
        //title: Text(Languages.of(context).languageAppBar),
        title: Text(
          'Language',
          style: TextStyle(color: Colors.deepOrange[400]),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[700],
                  blurRadius: 8,
                  spreadRadius: -3,
                  offset: Offset(0, 3.5),
                )
              ]),
          height: 300,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Languages.of(context).selectLanguage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              _createLanguageDropDown(),
              SizedBox(height: 27.5),
              // MaterialButton(
              //   elevation: 7.5,
              //   color: Colors.orange,
              //   textColor: Colors.white,
              //   onPressed: () {},
              //   child: Text('Languages.of('),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  _createLanguageDropDown() {
    print('THIS IS IN LANGUAGE PAGE ${LanguageData.languageList().last.name}');
    return DropdownButton<LanguageData>(
      iconSize: 30,
      hint: Text(
        'Languages',
        style: TextStyle(color: Colors.deepOrange[400]),
      ),
      onChanged: (LanguageData language) {
        changeLanguage(context, language.languageCode);
        Navigator.pop(context);
      },
      items: LanguageData.languageList()
          .map<DropdownMenuItem<LanguageData>>(
            (e) => DropdownMenuItem<LanguageData>(
              value: e,
              child: Text(e.name),
            ),
          )
          .toList(),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class LanguagePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           height: 200,
//           width: 300,
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Choose your Language'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
