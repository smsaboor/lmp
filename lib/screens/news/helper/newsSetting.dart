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
////import 'package:country_pickers/country.dart';
////import 'package:country_pickers/country_pickers.dart';
//
//class NewsSetting extends StatefulWidget {
//  final SharedPreferences prefs;
//
//  NewsSetting({this.prefs});
//
//  static final String path = "lib/src/pages/settings/settings1.dart";
//
//  @override
//  State<StatefulWidget> createState() {
//    return _NewsSettingState();
//  }
//}
//
//class _NewsSettingState extends State<NewsSetting> {
//  bool _dark;
//  final SharedPreferences prefs;
//
//  _NewsSettingState({this.prefs});
//
//  Country _selectedDialogCountry =
//      CountryPickerUtils.getCountryByPhoneCode('91');
//  Country _countryDisplay;
//  Language _selectedDropdownLanguage =
//      LanguagePickerUtils.getLanguageByIsoCode('ko');
//  Language _selectedDialogLanguage =
//      LanguagePickerUtils.getLanguageByIsoCode('ko');
//  Language _selectedCupertinoLanguage =
//      LanguagePickerUtils.getLanguageByIsoCode('ko');
//
//  //Email address
//  String _email;
//  String _countryCodeSP = '';
//  String _countryNameSP = '';
//  String _languageNameSP = '';
//  String _languageCodeSP = '';
//  String _imageURL = '';
//
//  //Whether or not the app can send out notifications
//  bool _notificationNews = true;
//  bool _notificationOffers = true;
//
//  //Whether or not pin codes can be used to authenticate
//  bool _allowPinCodes = false;
//
//  //Whether or not the presence of white-listed phones can be used to authenticate
//  bool _allowPhonePresenceDetection = false;
//
//  //Preferred temperature unit - fahrenheit or celsius?
//  String _temperatureUnit = 'fahrenheit';
//
//  save(String key, dynamic value) async {
//    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
//    if (value is bool) {
//      sharedPrefs.setBool(key, value);
//    } else if (value is String) {
//      sharedPrefs.setString(key, value);
//    } else if (value is int) {
//      sharedPrefs.setInt(key, value);
//    } else if (value is double) {
//      sharedPrefs.setDouble(key, value);
//    } else if (value is List<String>) {
//      sharedPrefs.setStringList(key, value);
//    }
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _dark = false;
//    restore();
//  }
//
//  restore() async {
//    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
//    setState(() {
//      _countryNameSP = (sharedPrefs.getString('countryName') ?? '');
//      _countryCodeSP = (sharedPrefs.getString('countryCode') ?? '91');
//      _languageNameSP = (sharedPrefs.getString('languageName') ?? '');
//      _languageCodeSP = (sharedPrefs.getString('languageCode') ?? '');
//      _notificationNews = (sharedPrefs.getBool('notNews') ?? false);
//      _notificationOffers = (sharedPrefs.getBool('notOffers') ?? false);
//      _imageURL = (sharedPrefs.getString('imageUrl') ?? '');
//      //TODO: More restoring of settings would go here...
//    });
//  }
//
//  Brightness _getBrightness() {
//    return _dark ? Brightness.dark : Brightness.light;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          leading: IconButton(
//            icon: Icon(
//              Icons.arrow_back,
//              semanticLabel: 'search',
//            ),
//            onPressed: () {
//              Navigator.pop(context, false);
//              Navigator.pop(context, false);
//            },
//          ),
//          actions: <Widget>[
//            Container(
//              margin: EdgeInsets.only(right: 6.0),
//              child: IconButton(
//                icon: Icon(Icons.account_circle, size: 32.0),
//                onPressed: () {},
//              ),
//            ),
//          ],
//          centerTitle: true,
//          title: title("Myzen", "News"),
//        ),
//        body: Theme(
//          isMaterialAppTheme: true,
//          data: ThemeData(
//            brightness: _getBrightness(),
//          ),
//          child: Stack(
//            fit: StackFit.expand,
//            children: <Widget>[
//              SingleChildScrollView(
//                padding: const EdgeInsets.all(16.0),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Center(
//                        child: SizedBox(
//                            width: 80,
//                            height: 60,
//                            child: Image.asset(_imageURL))),
//                    const SizedBox(height: 10.0),
//                    Card(
//                      elevation: 4.0,
//                      margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(10.0)),
//                      child: Column(
//                        children: <Widget>[
//                          ListTile(
//                            leading: Icon(
//                              Icons.language,
//                              color: Colors.redAccent,
//                            ),
//                            title: Text(_countryNameSP),
//                            trailing: Icon(Icons.keyboard_arrow_right),
//                            onTap: () {
//                              //open change location
//                              _openCountryPickerDialog();
//                            },
//                          ),
//                          _buildDivider(),
//                          ListTile(
//                            leading: Icon(
//                              FontAwesomeIcons.language,
//                              color: Colors.redAccent,
//                            ),
//                            title: Text(_languageNameSP),
//                            trailing: Icon(Icons.keyboard_arrow_right),
//                            onTap: () {
//                              _openLanguagePickerDialog();
//                              //open change language
//                            },
//                          ),
//                        ],
//                      ),
//                    ),
//                    const SizedBox(height: 20.0),
//                    Text(
//                      "Notification Settings",
//                      style: TextStyle(
//                        fontSize: 20.0,
//                        fontWeight: FontWeight.bold,
//                        color: Colors.redAccent,
//                      ),
//                    ),
//                    new SwitchListTile(
//                      activeColor: Colors.redAccent,
//                      title: const Text('Notifications News'),
//                      value: _notificationNews,
//                      onChanged: (bool value) {
//                        setState(() {
//                          _notificationNews = value;
//                        });
//                        save('notNews', value);
//                      },
//                      secondary: const Icon(
//                        Icons.notifications,
//                        color: Colors.redAccent,
//                      ),
//                    ),
//                    new SwitchListTile(
//                      activeColor: Colors.redAccent,
//                      title: const Text('Notifications Offers'),
//                      value: _notificationOffers,
//                      onChanged: (bool value) {
//                        setState(() {
//                          _notificationOffers = value;
//                        });
//                        save('notOffers', value);
//                      },
//                      secondary: const Icon(
//                        Icons.notifications,
//                        color: Colors.redAccent,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ));
//  }
//
//  Container _buildDivider() {
//    return Container(
//      margin: const EdgeInsets.symmetric(
//        horizontal: 8.0,
//      ),
//      width: double.infinity,
//      height: 1.0,
//      color: Colors.grey.shade400,
//    );
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
//                _selectedDialogCountry = country;
//                _countryDisplay = country;
//                _countryNameSP = country.name;
//                _imageURL =
//                    CountryPickerUtils.getFlagImageAssetPath(country.isoCode);
//              });
//              save('imageUrl', _imageURL);
//              save('countryCode', country.isoCode);
//              save('countryName', country.name);
//            },
//            itemBuilder: _buildDialogItem,
//            priorityList: [
//              CountryPickerUtils.getCountryByIsoCode('TR'),
//              CountryPickerUtils.getCountryByIsoCode('US'),
//            ],
//          ),
//        ),
//      );
//
//  // It's sample code of Dropdown Item.
//  Widget _buildDropdownItem(Language language) {
//    return Row(
//      children: <Widget>[
//        SizedBox(
//          width: 8.0,
//        ),
//        Text("${language.name} (${language.isoCode})"),
//      ],
//    );
//  }
//
//  // It's sample code of Dialog Item.
//  Widget _buildDialogItemLang(Language language) => Row(
//        children: <Widget>[
//          Text(language.name),
//          SizedBox(width: 8.0),
//          Flexible(child: Text("(${language.isoCode})"))
//        ],
//      );
//
//  void _openLanguagePickerDialog() => showDialog(
//        context: context,
//        builder: (context) => Theme(
//            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
//            child: LanguagePickerDialog(
//                titlePadding: EdgeInsets.all(8.0),
//                searchCursorColor: Colors.pinkAccent,
//                searchInputDecoration: InputDecoration(hintText: 'Search...'),
//                isSearchable: true,
//                title: Text('Select your language'),
//                onValuePicked: (Language language) {
//                  setState(() {
//                    _selectedDialogLanguage = language;
//                    _languageNameSP = language.name;
//                    _languageCodeSP = language.isoCode;
//                    print(_selectedDialogLanguage.name);
//                    print(_selectedDialogLanguage.isoCode);
//                  });
//                  save('languageCode', language.isoCode);
//                  save('languageName', language.name);
//                })),
//      );
//}
