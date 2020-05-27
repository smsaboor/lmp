//
//import 'package:flutter/cupertino.dart';
//import 'package:lakhimpur_kheri/model/model_setting.dart';
//import 'package:lakhimpur_kheri/model/user.dart';
//import 'package:sqflite/sqflite.dart';  // deals with SQLite database
//import 'dart:async';    //deals with asynchronous progrmming
//import 'dart:io';  //deals with files and folder
//import 'package:path_provider/path_provider.dart';
//
//
//class DataHelper {
//
//  //--------------------------- Common implementation for all Assets (Gold, Silver, Cash-in-hand, Cash-in-Bank)------------
//  static DataHelper _databaseHelper;    // Define Singleton DatabaseHelper object
//  static Database _database;                // Define Singleton Database object
//  static var total;
//  DataHelper._createInstance();
//  factory DataHelper() {
//    if (_databaseHelper == null) {
//      _databaseHelper = DataHelper._createInstance();
//    }
//    return _databaseHelper;
//  }
//
//  Future<Database> get database async {
//    if (_database == null) {
//      _database = await initializeDatabase();
//    }
//    return _database;
//  }
//
//  Future<Database> initializeDatabase() async {
//    Directory directory = await getApplicationDocumentsDirectory();
//    String path = directory.path + 'lakhimpur.db'; //'sadakaahManager27
//    var assetDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
//
//    return assetDatabase;
//  }
//
//  var resultsettion;
//  void _createDb(Database db, int newVersion) async {
//    await db.execute(
//        'CREATE TABLE user(userId INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT NOT NULL UNIQUE, password TEXT, registrationDate TEXT, isPaid TEXT, age INTEGER, paymentDate TEXT, city TEXT, pin INTEGER, familyId  INTEGER)');
//    await db.execute(
//        'CREATE TABLE setting(settingId INTEGER PRIMARY KEY AUTOINCREMENT, country TEXT, currency TEXT, nisab DOUBLE, startDate TEXT, endDate TEXT, goldRate18C DOUBLE, goldRate20C DOUBLE, goldRate22C DOUBLE, goldRate24C DOUBLE, silverRate18C DOUBLE, silverRate20C DOUBLE, silverRate22C DOUBLE, silverRate24C DOUBLE, userId INTEGER)');
//  }
//  //-----------------------------------------------------------------Setting Functions--------------------------------------------------------------------------
//  Future<List<Map<String, dynamic>>> getSettingMapList(int userid) async {
//    Database db = await this.database;
//    var result = await db.rawQuery('SELECT * FROM setting2 WHERE userId=?', ['$userid']);
//    return result;
//  }
//
//
//  // Get the 'Map List' [ List<Map> ] from the database and convert it to 'Gold List' [ List<ModelGold> ]
//  Future<List<ModelSetting>> getSettingList(int userid) async {
//    var settingMapList = await getSettingMapList(userid); // first Get 'Map List' from database
//    int count = settingMapList.length;         // second Count the number of map entries fetched from  db table
//    List<ModelSetting> settingList = List<ModelSetting>();//third create empty List of Gold
//    // For loop to copy all the 'Map list object' into our UsersList'
//    for (int i = 0; i < count; i++) {
//      settingList.add(ModelSetting.fromMapObject(settingMapList[i]));
//    }
//    return settingList;// finally return our Users list
//  }
//
//  Future<int> insertSetting(ModelSetting setting) async {
//    Database db = await this.database;
//    var result = await db.insert('setting2', setting.toMap());
//    return result;
//  }
//
//  Future<int> updateSetting(ModelSetting setting) async {
//    var db = await this.database;
//    var result = await db.update('setting2', setting.toMap(), where: 'settingId = ?', whereArgs: [setting.settingId]);
//    return result;
//  }
//
//  Future<int> deleteSetting(int id) async {
//    var db = await this.database;
//    int result = await db.rawDelete('DELETE FROM setting2 WHERE settingId = $id');
//    return result;
//  }
//
//  Future<int> getSettingCount() async {
//    Database db = await this.database;
//    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from setting2');
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }
//
//
////---------------------------- All Functions for User Table are implemented below---------------------------------
//// Get the 'Map List' [ List<Map> ] from the database and convert it to 'Gold List' [ List<ModelGold> ]
////
////  Future<List<Map<String, dynamic>>> getUserMapList() async {
////    Database db = await this.database;
////    var result = await db.rawQuery('SELECT * FROM user');
////    return result;
////  }
////  Future<List<ModelUsers>> getUserList() async {
////    var userMapList = await getUserMapList(); // first Get 'Map List' from database
////    int count = userMapList.length;         // second Count the number of map entries fetched from  db table
////    List<ModelUsers> userList = List<ModelUsers>();//third create empty List of Gold
////    // For loop to copy all the 'Map list object' into our UsersList'
////    for (int i = 0; i < count; i++) {
////      userList.add(ModelUsers.fromMapObject(userMapList[i]));
////    }
////    int lnght=userList.length;
////    String lenght=lnght.toString();
////    for(int i=0;i<=userList.length-1;i++) {
////      debugPrint(lenght);
////    }
////    return userList;// finally return our Users list
////  }
////
////
////
////  Future<List<Map<String, dynamic>>> getUserAuthenticationMapList(String paremail,String pwd) async {
////    Database db = await this.database;
//////    var result = await db.rawQuery('SELECT * FROM user WHERE email=?', ['$paremail']);
////    var result = await db.rawQuery('SELECT * FROM user WHERE email=? AND password=?', ['$paremail','$pwd']);
////    return result;
////  }
////  Future<List<ModelUsers>> getUserAuthentication(String email,String pwd) async {
////    var userAuthenticationMapList = await getUserAuthenticationMapList(email,pwd); // first Get 'Map List' from database
////    int count = userAuthenticationMapList.length;         // second Count the number of map entries fetched from  db table
////    List<ModelUsers> userList = List<ModelUsers>();//third create empty List of Gold
////    // For loop to copy all the 'Map list object' into our UsersList'
////    for (int i = 0; i < count; i++) {
////      userList.add(ModelUsers.fromMapObject(userAuthenticationMapList[i]));
////    }
////
////    int lnght=userList.length;
////    String lenght=lnght.toString();
////    for(int i=0;i<=userList.length-1;i++) {
////      debugPrint(lenght);
////    }
////    return userList;// finally return our Users list
////  }
////
////
////  Future<int> insertUser(ModelUsers user) async {
////    Database db = await this.database;
////    var result = await db.insert('user', user.toMap());
////    if(result != 0)
////      debugPrint('**************************************insert Successfully');
////    else
////      debugPrint('????????????????????????????????????????insert Failure');
////    return result;
////  }
////  Future<int> updateUser(ModelUsers user,) async {
////    var db = await this.database;
////    var result = await db.update('user', user.toMap(), where: 'userId = ?', whereArgs: [user.userId]);
////    return result;
////  }
////
////  Future<int> deleteUser(int id) async {
////    var db = await this.database;
////    int result = await db.rawDelete('DELETE FROM user WHERE userId = $id');
////    return result;
////  }
////
////  Future<int> getUserCount() async {
////    Database db = await this.database;
////    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from user');
////    int result = Sqflite.firstIntValue(x);
////    return result;
////  }
////
////
//
//}// End of Class
