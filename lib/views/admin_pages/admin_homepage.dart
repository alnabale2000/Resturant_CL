import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/views/admin_pages/add_category.dart';
import 'package:resturant/views/admin_pages/add_meal.dart';
import 'package:resturant/views/admin_pages/orders.dart';
import 'package:resturant/views/user_pages/home_page.dart';

class AdminHomepage extends StatefulWidget {
  @override
  _AdminHomepageState createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.deepOrange,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.swipe,
                color: Colors.deepOrange,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            )
          ],
          title: Text(
            'Admin Pannel',
            style: TextStyle(
              color: Colors.deepOrange[400],
            ),
          ),
          elevation: 2,
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _tabController,
            labelStyle: TextStyle(fontSize: 17),
            isScrollable: true,
            unselectedLabelColor: Colors.deepOrange[400],
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    colors: [Colors.deepOrange[400], Colors.green])),
            labelColor: Colors.white,
            tabs: [
              Tab(
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    // border: Border.all(color: Colors.amber, width: 1),
                  ),
                  child: Align(
                      alignment: Alignment.center, child: Text("?????????? ?????? ")),
                ),
              ),
              Tab(
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    // border: Border.all(color: Colors.amber, width: 1),
                  ),
                  child: Align(
                      alignment: Alignment.center, child: Text("?????? ????????")),
                ),
              ),
              Tab(
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    // border: Border.all(color: Colors.amber, width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("?????????? ??????????????"),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            AddCategory(
              tabController: _tabController,
            ),
            AddMeal(),
            Orders(),
          ],
        ),
      ),
    );
  }
}
