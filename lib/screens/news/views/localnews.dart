import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lakhimpur_kheri/screens/news/helper/newsSetting.dart';
import 'package:lakhimpur_kheri/screens/news/helper/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';



class LocalNews extends StatefulWidget {
  final _searchString;
  final SharedPreferences prefs;

  LocalNews(this._searchString,{this.prefs});

  @override
  _LocalNewsState createState() => _LocalNewsState(this._searchString,prefs: prefs);
}

class _LocalNewsState extends State<LocalNews> {
  String _searchString;
  final SharedPreferences prefs;
  _LocalNewsState(this._searchString, {this.prefs});
  bool _loading;
  var newslist;


  void getNews() async {
  NewsForKeyword newsKeyword = NewsForKeyword();
  await newsKeyword.getNewsForKeyword(_searchString);
  newslist = newsKeyword.news;
    setState(() {
      _loading = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getNews();
  }

  @override
  void dispose() {
    super.dispose();
  }
  Future<void> _launched;
  String phoneNumber;
  String launchUrl='https://www.google.com';

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchUniversalLinkIos(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(url, forceSafariVC:true);
      }
    }
  }
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Call the above function in the proper phone number format
  // To Launch the phone dialer, you need to append tel: before the phone number.

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }



  @override
  Widget build(BuildContext context) {
    return _safeAreaForCategory(newslist);
    }

  _safeAreaForCategory(var searchString) {
    return SafeArea(

      child: _loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: searchString.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NewsTile(
                        imgUrl:
                        searchString[index].urlToImage ?? "",
                        title: searchString[index].title ?? "",
                        desc:
                        searchString[index].description ?? "",
                        content: searchString[index].content ?? "",
                        posturl:
                        searchString[index].articleUrl ?? "",
                      );
                    }),
              ),

              RaisedButton(
                child: const Text("Launched in url"),
                onPressed: (){
                  setState(() {
                    _launched=_launchInBrowser(launchUrl);
                  });
                },

              ),
              RaisedButton(
                child: const Text("Launched in App"),
                onPressed: (){
                  setState(() {
                    _launched=_launchInApp(launchUrl);
                  });
                },

              ),
              RaisedButton(
                child: const Text("Launch Universal Link App"),
                onPressed: (){
                  setState(() {
                    _launched= _launchUniversalLinkIos('https://youtube.com');
                  });
                },
              ),
              RaisedButton(
                child: const Text("Make Phone Call"),
                onPressed: (){
                  setState(() {
                    _launched=  _makePhoneCall('tel:1234567890');
                  });
                },
              ),
              RaisedButton(
                child: const Text("Close web view after five second"),
                onPressed: (){
                  setState(() {
                    _launched=_launchInApp(launchUrl);
                  });
                  Timer(const Duration(seconds: 5),()
                  {
                    closeWebView();
                  });
                },
              ),
            SizedBox(height: 20,),
            FutureBuilder(
              future: _launched,
              builder: (BuildContext context,AsyncSnapshot<void> snapshot){
              if(snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
                else{
                  return Text('Launched.');
                }
              },
            )
            ],
          ),
        ),
      ),
    );
  }
}
