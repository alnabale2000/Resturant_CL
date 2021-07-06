import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/category.dart';
import 'package:resturant/random_states.dart';
import 'package:resturant/user_components/home_page_drawer.dart';
import 'package:resturant/user_components/user_swiper.dart';
import 'cart_page.dart';
import 'file:///C:/Users/NTC/AndroidStudioProjects/resturant/lib/user_components/sliver_header_delegate.dart';
import 'package:resturant/views/user_pages/meals.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:resturant/globals.dart' as globals;

class UserHomePage extends StatelessWidget {
  bool loading = false;
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

  var carsulCounter;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context);
    final randomState = Provider.of<RandomStates>(context);

    print('USER HOME TEST');

    List<Tab> tabBarItems = [];

    if (categories != null)
      for (Category category in categories) {
        tabBarItems.add(
          Tab(
            text: category.name,
            icon: globals.userCheck == 'true'
                ? GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () {
                      FireStoreService().deleteSingleCategoryDocument(
                        categoryName: category.name,
                      );
                    },
                  )
                : SizedBox(height: 0, width: 0),
          ),
        );
      }

    return categories == null
        ? Loading()
        : DefaultTabController(
            length: categories?.length ?? 0,
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              endDrawer: UserHomePageDrawer(),
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.deepOrange[400]),
                leading: globals.userCheck == 'true'
                    ? IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.deepOrange,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    : null,
                elevation: 2.5,
                centerTitle: true,
                title: Text(
                  'Restaurant Name',
                  style: TextStyle(
                    color: Colors.deepOrange[400],
                    fontSize: 22.5,
                    fontFamily: 'Pacifico',
                  ),
                ),
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.local_grocery_store,
                      color: Colors.deepOrange[400],
                    ),
                    color: Colors.deepOrange[400],
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cart()));
                    },
                  ),
                  IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState.openEndDrawer();
                      }),
                ],
              ),
              body: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    Container(
                      child: SliverGrid.extent(
                        maxCrossAxisExtent: 700,
                        childAspectRatio: 1.9,
                        children: <Widget>[
                          MealSwiper(),
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: SliverHeaderDelegate(
                        color: Colors.white,
                        tabBar: TabBar(
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Pacifico',
                          ), //For Selected tab
                          labelColor: Colors.deepOrange[400],
                          isScrollable: true,
                          tabs: tabBarItems,
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: tabBarItems.map((Tab tab) {
                    return Meals(
                      categoryName: tab.text,
                    );
                  }).toList(),
                ),
              ),
            ),
          );
  }
}
