import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/meal.dart';
import 'package:resturant/random_states.dart';

class MealDetails extends StatefulWidget {
  final Meal meal;
  final int index;

  MealDetails({this.meal, this.index});

  @override
  _MealDetailsState createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  int counter = 1;

  plus() {
    setState(() {
      counter = counter + 1;
    });
  }

  minmize() {
    if (counter > 1) {
      setState(() {
        counter = counter - 1;
      });
    } else
      counter = 1;
  }

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    final randomState = Provider.of<RandomStates>(context, listen: false);
    final _meal = widget.meal;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepOrange[400]),
        backgroundColor: Colors.white,
        title: Text(
          _meal.mealName,
          style: TextStyle(color: Colors.deepOrange[400]),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _meal.mealImage == 'No image'
                  ? Container(
                      width: double.infinity,
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: Icon(Icons.image_not_supported_rounded),
                      ),
                    )
                  : Hero(
                      tag: 'mealPic' + widget.index.toString(),
                      child: Container(
                        height: 260,
                        width: double.infinity,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            _meal.mealImage,
                          ),
                        ),
                      ),
                    ),
              Center(
                child: Container(
                  child: Text(
                    _meal.mealName,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "   Price : ",
                      style: TextStyle(fontSize: 22, color: Colors.black87),
                    ),
                    Container(
                      child: Text(
                        "${(_meal.mealPrice * counter).toStringAsFixed(2)} JD",
                        style: TextStyle(color: Colors.black87, fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      _meal.mealDetails,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: (BorderRadius.circular(23)),
                          color: Colors.deepOrange),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () => plus(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      child: Text(
                        '$counter',
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 22),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: (BorderRadius.circular(23)),
                          color: Colors.deepOrange),
                      child: IconButton(
                          icon: Icon(
                            Icons.minimize,
                            color: Colors.white,
                          ),
                          onPressed: () => minmize()),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '????????????????',
                        style: TextStyle(
                            color: Colors.deepOrange[400], fontSize: 17.5),
                      ),
                      Text(
                        'COMING SOON!',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 22.5,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(6.5),
                    border: Border.all(color: Colors.green[400]),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: FlipCard(
          direction: FlipDirection.VERTICAL,
          speed: 1500,
          onFlipDone: (bool val) {
            val ? print('what??') : Navigator.pop(context);
          },
          key: cardKey,
          front: Container(
            width: double.infinity,
            height: 70,
            child: FloatingActionButton(
              onPressed: () {
                FireStoreService().addToUserCart(
                  uid: randomState.getCurrentUser(),
                  mealName: _meal.mealName,
                  mealPrice: _meal.mealPrice,
                  mealDetails: _meal.mealDetails,
                  mealImage: _meal.mealImage,
                  count: counter,
                  totalPrice: _meal.mealPrice * counter,
                );
                cardKey.currentState.toggleCard();
              },
              child: Text(
                'Add To Cart',
                style: TextStyle(fontSize: 20, fontFamily: 'Pacifico'),
              ),
              isExtended: true,
            ),
          ),
          back: Container(
            decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 5),
                      color: Colors.black54,
                      spreadRadius: -6,
                      blurRadius: 10)
                ]),
            width: double.infinity,
            height: 70,
            child: Center(
              child: Text(
                'Added To Cart Successfully',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
