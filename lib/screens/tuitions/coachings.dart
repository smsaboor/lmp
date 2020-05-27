/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:lakhimpur_kheri/screens/about/developer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';

//import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:lakhimpur_kheri/screens/about/constants.dart';

class Coachings extends StatelessWidget {
  final Color yellow = Color(0xfffbc31b);
  final Color orange = Color(0xfffb6900);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.deepOrange),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                ...DEVELOPERS.map((dev) => _buildHeader(dev, context)).toList(),
                const SizedBox(height: 10.0),
                FittedBox(
                  child: CupertinoButton(
                    onPressed: () => _showModalBottomSheet(context),
                    borderRadius: BorderRadius.circular(50.0),
                    child: Text(
                      "Go",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: CupertinoColors.activeBlue),
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
  List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];
  String pkImage = "assets/flags/tr.png";
  Widget header() => Ink(
    decoration: BoxDecoration(
        gradient: LinearGradient(colors:kitGradients2)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage(pkImage),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Text("Pawan Kumar"),
          )
        ],
      ),
    ),
  );

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Material(
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.only(
                    topLeft: new Radius.circular(15.0),
                    topRight: new Radius.circular(15.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                header(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: false,
                    itemCount: 4,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListTile(
                          title: Text(
                            "Hello",
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                    ),
                  ),
                ),
              ],
            )));
  }
  Widget _buildHeader(Developer developer, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: MaterialButton(
        padding: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.grey.shade200,
        onPressed: () {
          _gotoDetailsPage(context, developer);
        },
        child: Row(
          children: <Widget>[
            Container(
                width: 80.0,
                height: 80.0,
                child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                        radius: 35.0,
                        backgroundImage:
                        CachedNetworkImageProvider(developer.imageUrl)))),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  developer.name,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(developer.profession),
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
                      developer.address,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _open(String url) async {
//    if(await canLaunch(url)) {
//      launch(url);
//    }
  }

  Widget _blueDetailRectangle() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    );
  }

  void _gotoDetailsPage(BuildContext context, Developer developer) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
              child: AlertDialog(
                actions: <Widget>[
                  RaisedButton(
                    color: Colors.green,
                    child: Text(
                      "                                 Got it !                                   ",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text("Coaching Detail",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontFamily: "Satisfy",
                            )),
                      ),
                      _buildDivider(),
                    ]),
                content: Container(
                  height: 300,
                  width: 400,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 260,
                            height: 160,
                            child: Image.asset("assets/hotel/room1.jpg"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          developer.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: Colors.purple,
                          ),
                          title: Text(developer.name),
                          trailing: Icon(Icons.edit),
                          onTap: () {
                            //open change password
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.language,
                            color: Colors.purple,
                          ),
                          title: Text(developer.address),
                          trailing: Icon(Icons.edit),
                          onTap: () {
                            //open change language
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          "Education Qualification",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        Text(
                          "Education Qualification",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        Text(
                          "Education Qualification",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        SwitchListTile(
                          activeColor: Colors.purple,
                          value: true,
                          title: Text("Received App Updates"),
                          onChanged: null,
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  clearForm() {}

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
