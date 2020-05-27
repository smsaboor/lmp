//import 'package:lakhimpur_kheri/screens/news2/a_news_app/blocs/news_bloc.dart';
//import 'package:lakhimpur_kheri/screens/news2/a_news_app/ui/views/search_bar.dart';
//import 'package:lakhimpur_kheri/screens/news2/a_news_app/ui/views/stream_builder.dart';
//import 'package:flutter/material.dart';
//import 'package:lakhimpur_kheri/screens/news/helper/newsSetting.dart';
//import 'package:lakhimpur_kheri/screens/news/helper/widgets.dart';
//import 'package:lakhimpur_kheri/screens/news2/a_news_app/blocs/functions.dart';
//import 'package:lakhimpur_kheri/zCountryPicker/country.dart';
//import 'package:lakhimpur_kheri/zCountryPicker/country_pickers.dart';
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:lakhimpur_kheri/screens/profile/profile.dart';
//import 'package:lakhimpur_kheri/zCountryPicker/country.dart';
//import 'package:lakhimpur_kheri/zCountryPicker/country_pickers.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:lakhimpur_kheri/zLanguagePicker/languages.dart';
//import 'package:lakhimpur_kheri/zLanguagePicker/language_pickers.dart';
//import 'package:lakhimpur_kheri/screens/news/helper/widgets.dart';
//
//ScrollController scrollControllerWorldNewsList;
//
//class WorldNews extends StatefulWidget {
//  @override
//  createState() => WorldNewsState();
//}
//
//class WorldNewsState extends State<WorldNews> {
//  TabController tabController;
//  String _countryIsoCodeSP = 'IN';
//
//  @override
//  void initState() {
//    setState(() {});
//    scrollControllerWorldNewsList = ScrollController(initialScrollOffset: 84);
//    super.initState();
//    restore();
//  }
//
//  restore() async {
//    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
//    setState(() {
//      _countryIsoCodeSP = (sharedPrefs.getString('countryIsoCode') ?? 'IN');
//    });
//  }
//
//  save(String key, dynamic value) async {
//    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
//    if (value is String) {
//      sharedPrefs.setString(key, value);
//    }
//  }
//
//  @override
//  void dispose() {
//    scrollControllerWorldNewsList.dispose();
//    super.dispose();
//  }
//
//  MyAppBar() {
//    return AppBar(
//      title: Center(
//        child: title(
//            CountryPickerUtils.getCountryByIsoCode(_countryIsoCodeSP).name,
//            "HeadLines"),
//      ),
//      elevation: 4,
//      backgroundColor: Colors.orangeAccent,
//      actions: <Widget>[
//        IconButton(
//          icon: Image.asset(
//              CountryPickerUtils.getFlagImageAssetPath(_countryIsoCodeSP)),
//          onPressed: () {
//            _openCountryPickerDialog();
//          },
//        ),
//      ],
//      bottom: TabBar(
//        labelColor: Colors.orangeAccent,
//        labelStyle: TextStyle(
//          fontSize: 13.0,
//          fontWeight: FontWeight.bold,
//          color: Colors.black,
//        ),
//        unselectedLabelColor: Colors.white,
//        indicatorSize: TabBarIndicatorSize.tab,
//        indicatorWeight: 2,
//        indicatorColor: Colors.red,
//        isScrollable: true,
//        indicator: BoxDecoration(
//            borderRadius: BorderRadius.only(
//                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//            color: Colors.white),
//        tabs: [
//          Tabs("Latest"),
//          Tabs("India"),
//          Tabs("World"),
//          Tabs("Business"),
//          Tabs("Entertainment"),
//          Tabs("General"),
//          Tabs("Health"),
//          Tabs("Science"),
//          Tabs("Sports"),
//          Tabs("Technology"),
//        ],
//        controller: tabController,
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    setState(() {});
//    return
//      SafeArea(
//        child: CustomScrollView(
//          controller: scrollControllerWorldNewsList,
//          slivers: <Widget>[
//            streamBuilder(bloc.allNews),
//          ],
//        ),
//      ),
//      SafeArea(
//        child: CustomScrollView(
//          controller: scrollControllerWorldNewsList,
//          slivers: <Widget>[
//            streamBuilder(bloc.allNews),
//          ],
//        ),
//      ),
//      SafeArea(
//        child: CustomScrollView(
//          controller: scrollControllerWorldNewsList,
//          slivers: <Widget>[
//            streamBuilder(bloc.allNews),
//          ],
//        ),
//      ),
//      SafeArea(
//        child: CustomScrollView(
//          controller: scrollControllerWorldNewsList,
//          slivers: <Widget>[
//            streamBuilder(bloc.allNews),
//          ],
//        ),
//      ),
//      SafeArea(
//        child: CustomScrollView(
//          controller: scrollControllerWorldNewsList,
//          slivers: <Widget>[
//            streamBuilder(bloc.allNews),
//          ],
//        ),
//      ),
//      SafeArea(
//        child: CustomScrollView(
//          controller: scrollControllerWorldNewsList,
//          slivers: <Widget>[
//            streamBuilder(bloc.allNews),
//          ],
//        ),
//      ),
//      SafeArea(
//        child: CustomScrollView(
//          controller: scrollControllerWorldNewsList,
//          slivers: <Widget>[
//            streamBuilder(bloc.allNews),
//          ],
//        ),
//      ),
//      SafeArea(
//        child: CustomScrollView(
//          controller: scrollControllerWorldNewsList,
//          slivers: <Widget>[
//            streamBuilder(bloc.allNews),
//          ],
//        ),
//      ),
//      SafeArea(
//        child: CustomScrollView(
//          controller: scrollControllerWorldNewsList,
//          slivers: <Widget>[
//            streamBuilder(bloc.allNews),
//          ],
//        ),
//      ),
//      SafeArea(
//          child: CustomScrollView(
//        controller: scrollControllerWorldNewsList,
//        slivers: <Widget>[
//          streamBuilder(bloc.allNews),
//        ],
//      )),
//    ]);
//  }
//
//  Widget _buildDialogItem(Country country) => Row(
//        children: <Widget>[
//          CountryPickerUtils.getDefaultFlagImage(country),
//          SizedBox(width: 12.0),
//          Flexible(child: Text(country.name))
//        ],
//      );
//
//  void _openCountryPickerDialog() => showDialog(
//        context: context,
//        builder: (context) => Theme(
//          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
//          child: CountryPickerDialog(
//            titlePadding: EdgeInsets.all(8.0),
//            searchCursorColor: Colors.pinkAccent,
//            searchInputDecoration: InputDecoration(hintText: 'Search...'),
//            isSearchable: true,
//            title: Text('Select your phone code'),
//            onValuePicked: (Country country) {
//              setState(() {
//                _countryIsoCodeSP = country.isoCode;
//              });
//              save('countryIsoCode', country.isoCode);
//            },
//            itemBuilder: _buildDialogItem,
//            priorityList: [
//              CountryPickerUtils.getCountryByIsoCode('IN'),
//              CountryPickerUtils.getCountryByIsoCode('US'),
//            ],
//          ),
//        ),
//      );
//}
