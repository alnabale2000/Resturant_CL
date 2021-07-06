import 'package:flutter/material.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/cart_meal.dart';
import 'package:resturant/globals.dart' as globals;

class ReceiptPage extends StatefulWidget {
  final List<CartMeal> cartMeals;

  ReceiptPage({this.cartMeals});

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TimeOfDay time;
  TimeOfDay picked;
  String valueChoice;
  List listItem = ['Branch1', 'Branch2'];

  DateTime now = new DateTime.now();
  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
  }

  Future<void> selectTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: time);
    if (picked != null) {
      setState(() {
        time = picked;
      });
    } else if (picked == null) {
      print("It is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(widget.cartMeals.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('From door'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 58.0),
              child: Container(
                width: size.width * 0.95,
                height: size.height * 0.75,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, top: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Text(
                              "Name  : ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: TextFormField(
                              validator: (String value) =>
                                  value.isEmpty ? 'Enter your name' : null,
                              cursorColor: Colors.green,
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: "Write your name:",
                                labelText: "Your name",
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                "Number  : ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  validator: (String value) =>
                                      value.isEmpty || value.length != 10
                                          ? 'Enter valid phone number'
                                          : null,
                                  controller: _numberController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Write your number:",
                                    labelText: "Your Number",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          children: [
                            Text(
                              "Time of recieve : ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: IconButton(
                                  icon: Icon(Icons.timer_outlined),
                                  onPressed: () {
                                    selectTime(context);
                                    print("time is $time");
                                  }),
                            ),
                            Text(
                              "${time.hour} : ${time.minute}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          children: [
                            Text(
                              "Branch: ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 38.0),
                              child: Container(
                                // height: 100,
                                width: 200,
                                child: DropdownButtonFormField<String>(
                                  validator: (String value) =>
                                      value == 'Select a branch '
                                          ? 'Enter a Branch to pick'
                                          : null,
                                  dropdownColor: Colors.green,
                                  focusColor: Colors.black,
                                  hint: Text("Select a branch ",
                                      style: TextStyle(color: Colors.white)),
                                  value: valueChoice,
                                  icon: Icon(Icons.arrow_downward),
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueChoice = newValue;
                                    });
                                  },
                                  items: listItem.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 38.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                FireStoreService(userId: globals.userId)
                                    .addOrder(
                                  mealName: widget.cartMeals[1].mealName,
                                );
                              } else
                                print('not validate');
                            },
                            child: Text(
                              "Reservation",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
