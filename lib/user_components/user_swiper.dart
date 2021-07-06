import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:resturant/random_states.dart';

class MealSwiper extends StatelessWidget {
  final List<String> _images = [
    'images/food.jpg',
    'images/food1.jpg',
    'images/food2.jpg',
    'images/food3.jpg',
    'images/food4.jpg',
    'images/food5.jpg',
    'images/food6.jpg',
    'images/food7.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final randomState = Provider.of<RandomStates>(context);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Swiper(
          itemCount: _images.length,
          onIndexChanged: (i) {
            randomState.setCarsulCountervalue(i);
          },
          itemBuilder: (BuildContext context, int index) => Image.asset(
            _images[index],
            fit: BoxFit.cover,
          ),
          autoplay: true,
          loop: true,
        ),
        Container(
          // color: Colors.green,
          width: 190,
          height: 40,
          alignment: Alignment.bottomCenter,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _images.length,
            // itemCount: 10,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child:
                      //4 ==0
                      Center(
                    child: randomState.carsulCounter == index
                        ? Container(
                            margin: EdgeInsets.all(5),
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.all(5),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
