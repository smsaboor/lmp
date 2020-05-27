/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:lakhimpur_kheri/screens/dashboard/hotels.dart';
import 'package:lakhimpur_kheri/screens/dashboard/jobs.dart';
import 'package:lakhimpur_kheri/screens/dashboard/news.dart';
import 'package:lakhimpur_kheri/screens/dashboard/offers.dart';
import 'package:lakhimpur_kheri/screens/dashboard/profile.dart';
import 'package:lakhimpur_kheri/screens/dashboard/schools.dart';
import 'package:lakhimpur_kheri/screens/dashboard/shops.dart';
import 'package:lakhimpur_kheri/screens/dashboard/users.dart';
import 'package:lakhimpur_kheri/screens/about/about.dart';
import 'package:lakhimpur_kheri/screens/jobs/jobs.dart';
import 'package:lakhimpur_kheri/screens/news/news.dart';

final List rooms = [
  {
    "image": "assets/hotel/room1.jpg",
    "title": "Awesome room near Bouddha"
  },
  {
    "image": "assets/hotel/room2.jpg",
    "title": "Peaceful Room"
  },
  {
    "image": "assets/hotel/room3.jpg",
    "title": "Beautiful Room"
  },
  {
    "image": "assets/hotel/room4.jpg",
    "title": "Vintage room near Pashupatinath"
  },
];
class DashBoard extends StatefulWidget {
  static final String path = "lib/src/pages/hotel/hhome.dart";

  DashBoard();

  @override
  State<StatefulWidget> createState() {
    return DashBoardState();
  }
}
class DashBoardState extends State<DashBoard> {

  DashBoardState();

  @override
  void initState() {
    super.initState();
  }
  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }
            ),
            expandedHeight: 180.0,
            backgroundColor: Colors.cyan,
            floating: true,
            flexibleSpace: ListView(
              children: <Widget>[
                SizedBox(height: 70.0,),
                Text("DashBoard", textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                    )),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.0,),),
          SliverToBoxAdapter(
            child: _buildCategories(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 800,
      child: Column(
        children: <Widget>[
//          SizedBox(width: 150.0,
//           child:Category(
//             icon: Icons.spa,
//            backgroundColor: Colors.green,
//            title: 'Lakhimpur-Kheri',
//          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    backgroundColor: Colors.pink,
                    icon: Icons.menu,
                    title: "News",
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new NewsDashboard()));
                  }),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    backgroundColor: Colors.blue,
                    title: "Jobs",
                    icon: Icons.account_circle,
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new JobsDashboard()));
                  }),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    icon: Icons.school,
                    backgroundColor: Colors.orange,
                    title: "Schools",
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => SchoolsDashboard ()));
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    backgroundColor: Colors.green,
                    icon: Icons.hotel,
                    title: "Hotel",
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new Jobs()));
                  }),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    backgroundColor: Colors.lightBlueAccent,
                    title: "Users",
                    icon: Icons.restaurant,
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new UsersDashboard()));
                  }),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    icon: Icons.local_cafe,
                    backgroundColor: Colors.orange,
                    title: "Shop",
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new ShopsDashboard()));
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              Category(
                backgroundColor: Colors.teal,
                icon: Icons.departure_board,
                title: "Tavels",
              ),
              SizedBox(
                width: 15.0,
              ),
              Category(
                backgroundColor: Colors.redAccent,
                title: "Shopping",
                icon: Icons.shopping_cart,
              ),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    icon: Icons.local_cafe,
                    backgroundColor: Colors.orange,
                    title: "Offers",
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new OffersDashboard()));
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              Category(
                backgroundColor: Colors.teal,
                icon: Icons.local_hospital,
                title: "Hospitals",
              ),
              SizedBox(
                width: 15.0,
              ),
              Category(
                backgroundColor: Colors.redAccent,
                title: "Gym",
                icon: Icons.accessibility_new,
              ),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(child: Category(
                icon: Icons.menu,
                backgroundColor: Colors.lightGreen,
                title: "others",
              ), onDoubleTap: () {
                // Update the state of the ap  .then((val)=>{_getRequests()})
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new DashBoard()));
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    backgroundColor: Colors.pink,
                    icon: Icons.menu,
                    title: "News",
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new Jobs()));
                  }),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    backgroundColor: Colors.blue,
                    title: "Jobs",
                    icon: Icons.account_circle,
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new Jobs()));
                  }),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    icon: Icons.school,
                    backgroundColor: Colors.orange,
                    title: "Schools",
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new Jobs()));
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    backgroundColor: Colors.green,
                    icon: Icons.hotel,
                    title: "Hotel",
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new Jobs()));
                  }),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    backgroundColor: Colors.lightBlueAccent,
                    title: "Restaurant",
                    icon: Icons.restaurant,
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new Jobs()));
                  }),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  child: Category(
                    icon: Icons.local_cafe,
                    backgroundColor: Colors.orange,
                    title: "Shop",
                  ),
                  onDoubleTap: () {
                    // Update the state of the ap  .then((val)=>{_getRequests()})
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) => new ProfilePage()));
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              Category(
                backgroundColor: Colors.teal,
                icon: Icons.departure_board,
                title: "Tavels",
              ),
              SizedBox(
                width: 15.0,
              ),
              Category(
                backgroundColor: Colors.redAccent,
                title: "Shopping",
                icon: Icons.shopping_cart,
              ),
              SizedBox(
                width: 15.0,
              ),
              Category(
                icon: Icons.offline_bolt,
                backgroundColor: Colors.lightGreen,
                title: "Offers",
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              Category(
                backgroundColor: Colors.teal,
                icon: Icons.local_hospital,
                title: "Hospitals",
              ),
              SizedBox(
                width: 15.0,
              ),
              Category(
                backgroundColor: Colors.redAccent,
                title: "Gym",
                icon: Icons.accessibility_new,
              ),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(child: Category(
                icon: Icons.menu,
                backgroundColor: Colors.lightGreen,
                title: "others",
              ), onDoubleTap: () {
                // Update the state of the ap  .then((val)=>{_getRequests()})
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => new DashBoard()));
              }),
            ],
          ),
        ],
      ),
    );
  }
}
class Category extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color backgroundColor;

  const Category({
    Key key,
    @required this.icon,
    @required this.title,
    this.backgroundColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(10.0),
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: Colors.white,),
            SizedBox(height: 5.0,),
            Text(title, style: TextStyle(
                color: Colors.white
            ))
          ],
        ),
      ),
    );
  }
}