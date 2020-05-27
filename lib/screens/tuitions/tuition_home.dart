import 'package:flutter/material.dart';
import 'package:lakhimpur_kheri/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lakhimpur_kheri/localisation/localization_two/app_translations.dart';
import 'package:lakhimpur_kheri/localisation/localization_two/application.dart';
import 'package:lakhimpur_kheri/screens/about/about.dart';
import 'package:lakhimpur_kheri/screens/tuitions/coachings.dart';
import 'package:lakhimpur_kheri/screens/tuitions/teacher.dart';

class Tuitions extends StatefulWidget {
  Tuitions();
  @override
  State<StatefulWidget> createState() {
    return TuitionsState();
  }
}
class TuitionsState extends State<Tuitions> {
  static final String path = "lib/src/pages/blog/bhome1.dart";
  final Color primaryColor = Colors.deepOrange;
  final Color bgColor = Color(0xffF9E0E3);
  final Color secondaryColor = Color(0xff324558);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Theme(
        data: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            textTheme: TextTheme(
              title: TextStyle(
                color: secondaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: IconThemeData(color: secondaryColor),
            actionsIconTheme: IconThemeData(
              color: secondaryColor,
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Theme.of(context).buttonColor,
          appBar: AppBar(
            centerTitle: true,
            title:  Text(AppTranslations.of(context).text("key_tuition_tc")),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
            bottom: TabBar(
              isScrollable: true,
              labelColor: primaryColor,
              indicatorColor: primaryColor,
              unselectedLabelColor: secondaryColor,
              tabs: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Coaching Centres", style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Home Teachers", style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Coachings(),
              ),
              Container(
                child: Teachers(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
