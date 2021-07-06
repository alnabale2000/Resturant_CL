import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  final String mealImage;
  final String mealName;
  final double mealPrice;
  final String mealDetails;
  final dynamic mealAdditional;

  Meal(
      {this.mealImage,
      this.mealName,
      this.mealPrice,
      this.mealDetails,
      this.mealAdditional});

  factory Meal.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Meal(
      mealName: data['meal_name'] ?? 'No name',
      mealDetails: data['meal_details'] ?? 'No details',
      mealImage: data['meal_image'] ?? 'No image',
      mealPrice: data['meal_price'] ?? 0,
      mealAdditional: data['meal_additional'] ?? 'No Additional stuff',
    );
  }
}

/*

Map mealAdditional={

'drink_options':[seven up,pepsi,miranda],
'add_sauce':[katchep,mionize,khardl],
'boolean':true

}


 */
