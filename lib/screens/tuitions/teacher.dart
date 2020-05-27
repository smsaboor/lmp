/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:lakhimpur_kheri/screens/about/developer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lakhimpur_kheri/screens/about/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/widgets.dart' as prefix1;
import 'package:image_picker/image_picker.dart';
import 'package:lakhimpur_kheri/screens/dashboard/offerEdit.dart';
import 'package:lakhimpur_kheri/screens/offers/offerEdit.dart';
import 'package:path/path.dart' as Path;
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:lakhimpur_kheri/localisation/localization_two/app_translations.dart';
import 'package:lakhimpur_kheri/localisation/localization_two/application.dart';
import 'package:flutter/material.dart';
import 'package:lakhimpur_kheri/features/taskPlanner/screens/calendar_page.dart';
import 'package:lakhimpur_kheri/features/taskPlanner/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:lakhimpur_kheri/features/taskPlanner/widgets/task_column.dart';
import 'package:lakhimpur_kheri/features/taskPlanner/widgets/active_project_card.dart';
import 'package:lakhimpur_kheri/features/taskPlanner/widgets/top_container.dart';


class Teachers extends StatefulWidget {
  Teachers();

  @override
  _TeachersState createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  _TeachersState();

  final db = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
          children: <Widget>[
            const Divider(
              height: 5.0,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: db.collection("teachers").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return Expanded(
                      child: new ListView(
                    children: generateStudentList(snapshot),
                  ));
                if (snapshot.hasData)
                  return Expanded(
                      child: new ListView(
                    children: generateStudentList(snapshot),
                  ));
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Container(child: CircularProgressIndicator());
                if (!snapshot.hasData)
                  return new Text(
                      AppTranslations.of(context).text("key_offers_noData"));
                return Container(
                  child: Text(
                    AppTranslations.of(context)
                        .text("key_offers_somethingWrong"),
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.green,
            icon: Icon(Icons.add),
            label: Text(
              AppTranslations.of(context).text("key_offers_button_float"),
            ),
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (_) =>
                        OffersEdit("email", '', '', '', '', '', '', false)),
              );
            }),
    );
  }

  generateStudentList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents.map<Widget>((doc) =>

        Container(
          margin: EdgeInsets.all(20.0),
          child: MaterialButton(
            padding: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: Colors.grey.shade200,
            onPressed: () {
              _gotoDetailsPage(context,doc["img_url"],doc["name"],doc["address"]);
            },
            child: Row(
              children: <Widget>[

                Container(
                    width: 80.0,
                    height: 80.0,
                    child: Hero(
                        tag: 'hero-rectangle',
                        child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                            radius: 35.0,
                          child:  (doc["img_url"] != null)
                              ? Image.network(
                            doc["img_url"],
                            fit: BoxFit.contain,
                          )
                              : Image.asset(
                            "assets/hotel/room1.jpg"         ,
                          ),
                          ))),),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      doc["name"],
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Text(doc["about"]),
                    SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.map,
                          size: 12.0,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          doc["mobile"],
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),),
        )    .toList();
  }
  Widget _blueDetailRectangle() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    );
  }
  void _gotoDetailsPage(BuildContext context,String url,String name,String address) {
    double width = MediaQuery.of(context).size.width;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) =>  Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 200,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios,
                            color: LightColors.kDarkBlue, size: 25.0),
                        Icon(Icons.share,
                            color: LightColors.kDarkBlue, size: 25.0),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 90.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: 1.0,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: LightColors.kRed,
                            backgroundColor: LightColors.kDarkYellow,
                            center: CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 35.0,
                              backgroundImage: AssetImage(
                                url,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  name,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: LightColors.kDarkBlue,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  address,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Educational Activities'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CalendarPage()),
                                  );
                                },
                                child: calendarIcon(),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          TaskColumn(
                            icon: Icons.alarm,
                            iconBackgroundColor: LightColors.kRed,
                            title: 'To Do',
                            subtitle: '5 tasks now. 1 started',
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TaskColumn(
                            icon: Icons.blur_circular,
                            iconBackgroundColor: LightColors.kDarkYellow,
                            title: 'In Progress',
                            subtitle: '1 tasks now. 1 started',
                          ),
                          SizedBox(height: 15.0),
                          TaskColumn(
                            icon: Icons.check_circle_outline,
                            iconBackgroundColor: LightColors.kBlue,
                            title: 'Done',
                            subtitle: '18 tasks now. 13 started',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          subheading('Active Projects'),
                          SizedBox(height: 5.0),
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: LightColors.kGreen,
                                loadingPercent: 0.01,
                                title: 'Medical App',
                                subtitle: '9 hours progress',
                              ),
                              SizedBox(width: 20.0),
                              ActiveProjectsCard(
                                cardColor: LightColors.kRed,
                                loadingPercent: 0.6,
                                title: 'Making History Notes',
                                subtitle: '20 hours progress',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              ActiveProjectsCard(
                                cardColor: LightColors.kDarkYellow,
                                loadingPercent: 0.45,
                                title: 'Sports App',
                                subtitle: '5 hours progress',
                              ),
                              SizedBox(width: 20.0),
                              ActiveProjectsCard(
                                cardColor: LightColors.kBlue,
                                loadingPercent: 0.9,
                                title: 'Online Flutter Course',
                                subtitle: '23 hours progress',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
    ));
  }
  _open(String url) async {
//    if(await canLaunch(url)) {
//      launch(url);
//    }
  }
  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
