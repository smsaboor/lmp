//import 'package:flutter/material.dart';
//import 'package:lakhimpur_kheri/helper/database_helper.dart';
//import 'package:lakhimpur_kheri/model/model_cash.dart';
//import 'package:lakhimpur_kheri/model/model_loan.dart';
//import 'package:lakhimpur_kheri/model/model_metal.dart';
//import 'package:lakhimpur_kheri/model/model_riba.dart';
//import 'package:lakhimpur_kheri/model/model_setting.dart';
//import 'package:lakhimpur_kheri/model/model_user_registration.dart';
//import 'package:lakhimpur_kheri/screens/about/about.dart';
//import 'package:lakhimpur_kheri/screens/demoFile.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:lakhimpur_kheri/login.dart';
//import 'package:pie_chart/pie_chart.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:share/share.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:country_pickers/country.dart';
//import 'package:country_pickers/country_pickers.dart';
//
//final List rooms = [
//  {
//    "image": "assets/hotel/room1.jpg",
//    "title": "Awesome room near Bouddha"
//  },
//  {
//    "image": "assets/hotel/room2.jpg",
//    "title": "Peaceful Room"
//  },
//  {
//    "image": "assets/hotel/room3.jpg",
//    "title": "Beautiful Room"
//  },
//  {
//    "image": "assets/hotel/room4.jpg",
//    "title": "Vintage room near Pashupatinath"
//  },
//];
//
//class HomePage extends StatefulWidget {
//  String email;
//  int userId;
//  int familyId;
//  bool logoutStatus;
//  int status;
//  UserDetails detailsUser;
//  ModelUsers user;
//
//  HomePage.googleLogin(this.status, this.logoutStatus,this.userId,this.user,
//      {Key key, @required this.detailsUser});
//
//  HomePage(
//      this.status, this.email, this.userId, this.familyId, this.logoutStatus);
//
//  @override
//  State<StatefulWidget> createState() {
//    if (status == 1) {
//      return HomePageState.googleLogin(status, this.logoutStatus,this.userId,this.user, detailsUser);
//    } else {
//      return HomePageState(status, email, userId, familyId, logoutStatus);
//    }
//  }
//}
//
//class HomePageState extends State<HomePage> {
//  String email;
//  int userId;
//  int familyId;
//  bool logoutStatus;
//  UserDetails detailsUser;
//  ModelUsers user;
//  int status;
//  HomePageState.googleLogin(this.status, this.logoutStatus, this.userId, this.user, this.detailsUser);
//  HomePageState(this.status, this.email, this.userId, this.familyId, this.logoutStatus);
//
//  String courrenyCode;
//  String finalPhotoURL;
//  String finalUserName;
//  String finalUserEmail;
//  String finalProvider;
//  String startDate = '', endDate = '';
//  double nisab = 0.0, goldRate = 0.0, silverRate = 0.0;
//
//
//  SharedPreferences prefs;
//  int countGA=0;
//  final GoogleSignIn _gSignIn = GoogleSignIn();
//  Country _selectedDialogCountry;
//  var cash;
//  DataHelper databaseHelper = DataHelper();
//  List<ModelSetting> settingList;
//  List<ModelCash> cashList;
//  List<ModelMetal> metalList;
//  List<ModelUsers> userList;
//  List<ModelLoan> loanList;
//  List<ModelRiba> ribaList;
//  int count = 0;
//  //---------Riba--------------
//  int totalRibaReceived = 0;
//  int totalRibaPaid = 0;
//  double totalRibaReceivedD = 0.0;
//  double totalRibaPaidD = 0.0;
//  int totalRibaAmount = 0;
//
//  //---------Asset-------------
//  int totalCashInHand = 0;
//  int totalCashInBank = 0;
//  int totalGold = 0;
//  int totalSilver = 0;
//  double totalCashInHandD = 0.0;
//  double totalCashInBankD = 0.0;
//  double totalGoldD = 0.0;
//  double totalSilverD = 0.0;
//  int totalAssetAmount = 0;
//
////----------Loan---------------
//  int totalBorrow = 0;
//  int totalLendSecure = 0;
//  int totalLendInsecure = 0;
//  double totalBorrowD = 0.0;
//  double totalLendSecureD = 0.0;
//  double totalLendInsecureD = 0.0;
//  int totalLoanAmount = 0;
//
//  int totalSadaqaahAmount = 0;
//
//  ModelSetting setting;
//
//
//  @override
//  void initState() {
//    super.initState();
//    if (status == 1) {
//      getUserAuthentication();
//      finalPhotoURL = detailsUser.photoUrl;
//      finalUserName = detailsUser.userName;
//      finalUserEmail = detailsUser.userEmail;
//    } else {
//      finalPhotoURL = '';
//      finalUserName = this.email;
//      finalUserEmail = this.email;
//
//    }
//    getUserAuthentication();
//  }
//
//  Future<bool> _onBackPressed() {
//    return showDialog(
//        context: context,
//        builder: (context) => AlertDialog(
//          title: Text("Do you want to Exit ?"),
//          actions: <Widget>[
//            FlatButton(
//              child: Text("No"),
//              onPressed: () => Navigator.pop(context, false),
//            ),
//            FlatButton(
//              child: Text("Yes"),
//              onPressed: () => Navigator.pop(context, true),
//            ),
//          ],
//        ));
//  }
//
//  _getRequests() async {
//    updateListViewSetting(userId);
//    cashList = List<ModelCash>();
//    userList = List<ModelUsers>();
//    metalList = List<ModelMetal>();
//    settingList = List<ModelSetting>();
//    ribaList = List<ModelRiba>();
//    updateListViewSetting(this.userId);
//    updateListViewCash('cash', 'cashinhand', this.userId);
//    updateListViewCash('cash', 'cashinbank', this.userId);
//    updateListViewMetal('metal', 'gold', this.userId);
//    updateListViewMetal('metal', 'silver', this.userId);
//    updateListAllLoan(this.userId);
//    updateListAllRiba(this.userId);
//    updateListRibaPaid(this.userId);
//    updateListRibaReceived(this.userId);
//    updateListViewBorrow('loan', 'borrow', this.userId);
//    updateListViewLendSecure('loan', 'lendsecure', this.userId);
//    updateListViewLendInsecure('loan', 'lendinsecure', this.userId);
//    getAllTotal();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    if (cashList == null) {
//      updateListViewSetting(this.userId);
//      cashList = List<ModelCash>();
//      userList = List<ModelUsers>();
//      metalList = List<ModelMetal>();
//      settingList = List<ModelSetting>();
//      ribaList = List<ModelRiba>();
//      updateListViewSetting(this.userId);
//      updateListViewCash('cash', 'cashinhand', this.userId);
//      updateListViewCash('cash', 'cashinbank', this.userId);
//      updateListViewMetal('metal', 'gold', this.userId);
//      updateListViewMetal('metal', 'silver', this.userId);
//      updateListAllLoan(this.userId);
//      updateListAllRiba(this.userId);
//      updateListRibaPaid(this.userId);
//      updateListRibaReceived(this.userId);
//      updateListViewBorrow('loan', 'borrow', this.userId);
//      updateListViewLendSecure('loan', 'lendsecure', this.userId);
//      updateListViewLendInsecure('loan', 'lendinsecure', this.userId);
//      getAllTotal();
//    }
//
//    return WillPopScope(
//        onWillPop: _onBackPressed,
//        child: new Scaffold(
//          appBar: AppBar(
//            title: Text('Lakhimpur Kheri'),
//            actions: <Widget>[
////
//              IconButton(
//                icon: Icon(
//                  Icons.settings,
//                  size: 25.0,
//                  color: Colors.white,
//                ),
//                onPressed: () {
//                },
//              ),
//            ],
//          ),
//          body: getListView(),
//          drawer: Drawer(
//            child: ListView(
//              // Important: Remove any padding from the ListView.
//              padding: EdgeInsets.zero,
//              children: <Widget>[
//                DrawerHeader(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: <Widget>[
//                      CircleAvatar(
//                        backgroundImage: NetworkImage(finalPhotoURL),
//                        radius: 25.0,
//                      ),
//                      SizedBox(height: 5.0),
//                      Text(
//                        "Name :" + finalUserName,
//                        style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                            color: Colors.black,
//                            fontSize: 14.0),
//                      ),
//                      SizedBox(height: 5.0),
//                      Text(
//                        "Email :" + finalUserEmail,
//                        style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                            color: Colors.black,
//                            fontSize: 14.0),
//                      ),
//                    ],
//                  ),
//                  decoration: BoxDecoration(
//                    color: Colors.blue,
//                  ),
//                ),
//                ListTile(
//                    title: Row(
//                      children: <Widget>[
//                        Icon(Icons.account_balance),
//                        Padding(
//                          padding: EdgeInsets.only(left: 8.0),
//                          child: Text("About City"),
//                        )
//                      ],
//                    ),
//                    onTap: () {
//                      Navigator.pop(context, true);
//                      // Update the state of the ap  .then((val)=>{_getRequests()})
//                      Navigator.of(context)
//                          .push(
//                        new MaterialPageRoute(
//                            builder: (_) =>
//                            new AboutLakhimpur(                            )),
//                      )
//                          .then((val) => {_getRequests()});
//                    }
//
//
//                ),
//                ListTile(
//                    title: Row(
//                      children: <Widget>[
//                        Icon(Icons.camera_alt),
//                        Padding(
//                          padding: EdgeInsets.only(left: 8.0),
//                          child: Text("Loan"),
//                        )
//                      ],
//                    ),
//                    onTap: () {
//                      Navigator.pop(context, true);
//                      // Update the state of the ap  .then((val)=>{_getRequests()})
//                      Navigator.of(context)
//                          .push(
//                        new MaterialPageRoute(
//                            builder: (_) =>
//                            new DemoFile(                            )),
//                      )
//                          .then((val) => {_getRequests()});
//                    }
//
//
//                ),
//                ListTile(
//                    title: Row(
//                      children: <Widget>[
//                        Icon(Icons.attach_money),
//                        Padding(
//                          padding: EdgeInsets.only(left: 8.0),
//                          child: Text("Riba"),
//                        )
//                      ],
//                    ),
//                    onTap: () {
//                      Navigator.pop(context, true);
//                      // Update the state of the ap  .then((val)=>{_getRequests()})
//                      Navigator.of(context)
//                          .push(
//                        new MaterialPageRoute(
//                            builder: (_) =>
//                            new DemoFile(                            )),
//                      )
//                          .then((val) => {_getRequests()});
//                    }
//
//                ),
//                ListTile(
//                    title: Row(
//                      children: <Widget>[
//                        Icon(Icons.camera_alt),
//                        Padding(
//                          padding: EdgeInsets.only(left: 8.0),
//                          child: Text("Zakat"),
//                        )
//                      ],
//                    ),
//                    onTap: () {
//                      Navigator.pop(context, true);
//                      // Update the state of the ap  .then((val)=>{_getRequests()})
//                      Navigator.of(context)
//                          .push(
//                        new MaterialPageRoute(
//                            builder: (_) => new DemoFile(                            )),
//                      )
//                          .then((val) => {_getRequests()});
//                    }
//                ),
//                ListTile(
//                    title: Row(
//                      children: <Widget>[
//                        Icon(Icons.build),
//                        Padding(
//                          padding: EdgeInsets.only(left: 8.0),
//                          child: Text("Setting"),
//                        )
//                      ],
//                    ),
//                    onTap: () {
//                      Navigator.pop(context, true);
//                      // Update the state of the ap  .then((val)=>{_getRequests()})
//                      Navigator.of(context)
//                          .push(
//                        new MaterialPageRoute(
//                            builder: (_) => new DemoFile(                            )),
//                      )
//                          .then((val) => {_getRequests()});
//                    }
//                ),
//                ListTile(
//                  title: Row(
//                    children: <Widget>[
//                      Icon(Icons.help),
//                      Padding(
//                        padding: EdgeInsets.only(left: 8.0),
//                        child: Text("Help"),
//                      )
//                    ],
//                  ),
//                  onTap: () {
//                    // Update the state of the app
//                    // ...
//                    // Then close the drawer
//                    Navigator.pop(context);
//                  },
//                ),
//                ListTile(
//                  title: Row(
//                    children: <Widget>[
//                      Icon(Icons.share),
//                      Padding(
//                        padding: EdgeInsets.only(left: 8.0),
//                        child: Text("Share"),
//                      )
//                    ],
//                  ),
//                  onTap: () {
//                    Share.share('Install and Manage Your Zakat https://play.google.com/store/apps/details?id=com.quranreading.zakatcalculator&hl=en_IN ', subject: 'Manage your zakat!');
//
//                  },
//                ),
//                ListTile(
//                  title: Row(
//                    children: <Widget>[
//                      Icon(Icons.lock_open),
//                      Padding(
//                        padding: EdgeInsets.only(left: 8.0),
//                        child: Text("Logout"),
//                      )
//                    ],
//                  ),
//                  onTap: () async {
//                    prefs = await SharedPreferences.getInstance();
//                    prefs?.clear();
//                    _gSignIn.signOut();
//                    if(logoutStatus==true) {
//                      Navigator.pop(context, true);
//                      Navigator.pop(context, true);
//                    }
//                    else {
//                      Navigator.pushReplacement(context,
//                          MaterialPageRoute(
//                              builder: (BuildContext ctx) => LoginScreen(false)
//                          ));
//                    }
//                  },
//                ),
//              ],
//            ),
//          ),
//        ));
//  }
//
//  ListView getListView() {
//    Map<String, double> dataMapAsset = new Map();
//    {
//      dataMapAsset.putIfAbsent("Cash    ", () => totalCashInHandD);
//      dataMapAsset.putIfAbsent("Bank    ", () => totalCashInBankD);
//      dataMapAsset.putIfAbsent("Gold    ", () => totalGoldD);
//      dataMapAsset.putIfAbsent("Silver  ", () => totalSilverD);
//    }
//    ;
//    Map<String, double> dataMapRiba = new Map();
//    {
//      dataMapRiba.putIfAbsent("Received", () => totalRibaReceivedD);
//      dataMapRiba.putIfAbsent("Paid", () => totalRibaPaidD);
//    }
//    ;
//    Map<String, double> dataMapLoan = new Map();
//    {
//      dataMapLoan.putIfAbsent("Borrow  ", () => totalBorrowD);
//      dataMapLoan.putIfAbsent("Lend\nSecure  ", () => totalLendSecureD);
//      dataMapLoan.putIfAbsent("Lend\nInsecure ", () => totalLendInsecureD);
//    }
//    ;
//    Map<String, double> dataMapZakat = new Map();
//    {
//      dataMapZakat.putIfAbsent("Paid  ", () => 0);
//      dataMapZakat.putIfAbsent("Unpaid  ", () => 5);
//    }
//    ;
//
//    return ListView(
//      children: <Widget>[
//        new GestureDetector(
//          onTap: () {
//            // Change the color of the container beneath
//            Navigator.of(context)
//                .push(
//              new MaterialPageRoute(
//                  builder: (_) => new DemoFile(                            )),
//            )
//                .then((val) => {_getRequests()});
//          },
//          child: Container(
//            width: 200,
//            height: 200.0,
//            child: Row(children: <Widget>[
//              SizedBox(
//                width: 30.0,
//              ),
//              Text(
//                'Assets',
//                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
//              ),
//              SizedBox(
//                width: 50.0,
//              ),
//              PieChart(
//                dataMap: dataMapAsset,
////                legendFontColor: Colors.blueGrey[900],
////                legendFontSize: 14.0,
////                legendFontWeight: FontWeight.w500,
//                animationDuration: Duration(milliseconds: 100),
//                chartLegendSpacing: 32.0,
//                chartRadius: MediaQuery.of(context).size.width / 4,
//                showChartValuesInPercentage: true,
//                showChartValues: true,
////                chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
//              ),
//            ]),
//          ),
//        ),
//        new GestureDetector(
//          onTap: () {
//            // Change the color of the container beneath
//            Navigator.of(context)
//                .push(
//              new MaterialPageRoute(
//                  builder: (_) =>new DemoFile(                            )),
//            )
//                .then((val) => {_getRequests()});
//          },
//          child: Container(
//            height: 200.0,
//            width: 200.0,
//            child: Row(children: <Widget>[
//              SizedBox(
//                width: 30.0,
//              ),
//              Text(
//                'Loan  ',
//                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
//              ),
//              SizedBox(
//                width: 50.0,
//              ),
//              PieChart(
//                dataMap: dataMapLoan,
////                legendFontColor: Colors.blueGrey[900],
////                legendFontSize: 14.0,
////                legendFontWeight: FontWeight.w500,
//                animationDuration: Duration(milliseconds: 800),
//                chartLegendSpacing: 32.0,
//                chartRadius: MediaQuery.of(context).size.width / 4,
//                showChartValuesInPercentage: true,
//                showChartValues: true,
////                chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
//              ),
//            ]),
//          ),
//        ),
//        new GestureDetector(
//          onTap: () {
//            // Change the color of the container beneath
//            Navigator.of(context)
//                .push(
//              new MaterialPageRoute(
//                  builder: (_) =>new DemoFile(                            )),
//            )
//                .then((val) => {_getRequests()});
//          },
//          child: Container(
//            height: 200.0,
//            width: 200.0,
//            child: Row(children: <Widget>[
//              SizedBox(
//                width: 30.0,
//              ),
//              Text(
//                'Riba  ',
//                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
//              ),
//              SizedBox(
//                width: 50.0,
//              ),
//              PieChart(
//                dataMap: dataMapRiba,
////                legendFontColor: Colors.blueGrey[900],
////                legendFontSize: 14.0,
////                legendFontWeight: FontWeight.w500,
//                animationDuration: Duration(milliseconds: 800),
//                chartLegendSpacing: 32.0,
//                chartRadius: MediaQuery.of(context).size.width / 4,
//                showChartValuesInPercentage: true,
//                showChartValues: true,
////                chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
//              ),
//            ]),
//          ),
//        ),
//        new GestureDetector(
//          onTap: () {
//            // Change the color of the container beneath
//            Navigator.of(context)
//                .push(
//              new MaterialPageRoute(
//                  builder: (_) => new DemoFile(                            )),
//            )
//                .then((val) => {_getRequests()});
//          },
//          child: Container(
//            height: 200.0,
//            width: 200.0,
//            child: Row(children: <Widget>[
//              SizedBox(
//                width: 30.0,
//              ),
//              Text(
//                'Zakat ',
//                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
//              ),
//              SizedBox(
//                width: 50.0,
//              ),
//              PieChart(
//                dataMap: dataMapZakat,
////                legendFontColor: Colors.blueGrey[900],
////                legendFontSize: 14.0,
////                legendFontWeight: FontWeight.w500,
////                animationDuration: Duration(milliseconds: 800),
//                chartLegendSpacing: 32.0,
//                chartRadius: MediaQuery.of(context).size.width / 4,
//                showChartValuesInPercentage: true,
//                showChartValues: true,
////                chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
//              ),
//            ]),
//          ),
//        ),
//      ],
//    );
//  }
//
//  void updateListViewSetting(int finaluserid) {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelSetting>> settingListFuture =
//      databaseHelper.getSettingList(finaluserid);
//      settingListFuture.then((settingList) {
//        setState(() {
//          this.settingList = settingList;
//          this.count = settingList.length;
//          this.nisab = settingList[0].nisab;
//          _selectedDialogCountry =
//              CountryPickerUtils.getCountryByPhoneCode('${settingList[0].country}');
//          this.startDate = settingList[0].startDate;
//          this.endDate = settingList[0].endDate;
////          courrenyCode=_selectedDialogCountry.currencyCode;
//        });
//      });
//    });
//  }
//
//
//  void updateListViewCash(String table, String type, int finaluserid) {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelCash>> cashListFuture =
//      databaseHelper.getCashList(table, type, finaluserid);
//      cashListFuture.then((cashList) {
//        setState(() {
//          this.cashList = cashList;
//          this.count = cashList.length;
//          if (type == 'cashinhand') {
//            totalCashInHand = getCashTotal();
//            double total = totalCashInHand / 100;
//            totalCashInHandD = total;
//            totalAssetAmount = getAllTotal();
//          } else {
//            totalCashInBank = getCashTotal();
//            double total = totalCashInBank / 100;
//            totalCashInBankD = total;
//            totalAssetAmount = getAllTotal();
//          }
//        });
//      });
//    });
//  }
//
//  int getCashTotal() {
//    double totalCash = 0.0;
//    for (int i = 0; i <= cashList.length - 1; i++) {
//      totalCash = totalCash + this.cashList[i].amount;
//    }
//    return totalCash.round();
//  }
//
//  // functions for metal.................................................
//  void updateListViewMetal(String table, String type, int finaluserid) {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelMetal>> cashListFuture =
//      databaseHelper.getMetalList(table, type, finaluserid);
//      cashListFuture.then((metalList) {
//        setState(() {
//          this.metalList = metalList;
//          this.count = metalList.length;
//          if (type == 'gold') {
//            totalGold = getMetalTotalAmount(type);
//            double total = totalGold / 100;
//            totalGoldD = total;
//            totalAssetAmount = getAllTotal();
//          } else {
//            totalSilver = getMetalTotalAmount(type);
//            double total = totalSilver / 100;
//            totalSilverD = total;
//            totalAssetAmount = getAllTotal();
//          }
//        });
//      });
//    });
//  }
//
//  int getMetalTotalAmount(String metal){
//    double totalWeight18CG =0.0;
//    double totalWeight20CG =0.0;
//    double totalWeight22CG =0.0;
//    double totalWeight24CG =0.0;
//    double totalWeight18CS =0.0;
//    double totalWeight20CS =0.0;
//    double totalWeight22CS =0.0;
//    double totalWeight24CS =0.0;
//    double totalAmount18CG =0.0;
//    double totalAmount20CG =0.0;
//    double totalAmount22CG =0.0;
//    double totalAmount24CG =0.0;
//    double GTtotalAmountGold =0.0;
//    double totalAmount18CS =0.0;
//    double totalAmount20CS =0.0;
//    double totalAmount22CS =0.0;
//    double totalAmount24CS =0.0;
//    double GTtotalAmountSilver =0.0;
//    double totalAmount=0.0;
//    if(metal=='gold') {
//      for (int i = 0; i <= metalList.length - 1; i++) {
//        if (metalList[i].carat == 18) {
//          totalWeight18CG = totalWeight18CG + this.metalList[i].weight;
//        }
//        else if (metalList[i].carat == 20) {
//          totalWeight20CG = totalWeight20CG + this.metalList[i].weight;
//        }
//        else if (metalList[i].carat == 22) {
//          totalWeight22CG = totalWeight22CG + this.metalList[i].weight;
//        }
//        else if (metalList[i].carat == 24) {
//          totalWeight24CG = totalWeight24CG + this.metalList[i].weight;
//        }
//      }
//      totalAmount18CG=totalWeight18CG*this.settingList[0].goldRate18C;
//      totalAmount20CG=totalWeight20CG*this.settingList[0].goldRate20C;
//      totalAmount22CG=totalWeight22CG*this.settingList[0].goldRate22C;
//      totalAmount24CG=totalWeight24CG*this.settingList[0].goldRate24C;
//      GTtotalAmountGold=totalAmount18CG+totalAmount20CG+totalAmount22CG+totalAmount24CG;
//      totalAmount=GTtotalAmountGold;
//    }
//    else{
//      for (int i = 0; i <= metalList.length - 1; i++) {
//        if (metalList[i].carat == 18) {
//          totalWeight18CS = totalWeight18CS + this.metalList[i].weight;
//        }
//        else if (metalList[i].carat == 20) {
//          totalWeight20CS = totalWeight20CS + this.metalList[i].weight;
//        }
//        else if (metalList[i].carat == 22) {
//          totalWeight22CS = totalWeight22CS + this.metalList[i].weight;
//        }
//        else if (metalList[i].carat == 24) {
//          totalWeight24CS = totalWeight24CS + this.metalList[i].weight;
//        }
//      }
//      totalAmount18CS=totalWeight18CS*this.settingList[0].silverRate18C;
//      totalAmount20CS=totalWeight20CS*this.settingList[0].silverRate20C;
//      totalAmount22CS=totalWeight22CS*this.settingList[0].silverRate22C;
//      totalAmount24CS=totalWeight24CS*this.settingList[0].silverRate24C;
//      GTtotalAmountSilver=totalAmount18CS+totalAmount20CS+totalAmount22CS+totalAmount24CS;
//      totalAmount=GTtotalAmountSilver;
//    }
//    return totalAmount.round();
//  }
//
//  int getAllTotal() {
//    int allTotal = 0;
//    allTotal = totalCashInHand + totalCashInBank + totalGold + totalSilver;
//    return allTotal;
//  }
//
//  //-------------------------------------------------------------------------------
//  void updateUserListView() {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelUsers>> metalListFuture = databaseHelper.getUserList();
//      metalListFuture.then((userList) {
//        setState(() {
//          this.userList = userList;
//          this.count = userList.length;
//        });
//      });
//    });
//  }
//
//  void updateListAllLoan(int userId) {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelLoan>> loanListFuture =
//      databaseHelper.getTotalLoanList(userId);
//      loanListFuture.then((LoanList) {
//        setState(() {
//          this.loanList = LoanList;
//          this.count = LoanList.length;
//          totalLoanAmount = getloanTotal();
//        });
//      });
//    });
//  }
//
//  int getloanTotal() {
//    double totalAmountborrow = 0;
//    for (int i = 0; i <= loanList.length - 1; i++) {
//      totalAmountborrow = totalAmountborrow + this.loanList[i].amount;
//    }
//    return totalAmountborrow.round();
//  }
//
//  void updateListAllRiba(int userId) {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelRiba>> loanListFuture =
//      databaseHelper.getRibaList(userId);
//      loanListFuture.then((ribaList) {
//        setState(() {
//          this.ribaList = ribaList;
//          this.count = ribaList.length;
//          totalRibaAmount = getRibaTotal();
//        });
//      });
//    });
//  }
//
//  void updateListRibaReceived(int userId) {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelRiba>> loanListFuture =
//      databaseHelper.getRibaListReceived(userId);
//      loanListFuture.then((ribaList) {
//        setState(() {
//          this.ribaList = ribaList;
//          this.count = ribaList.length;
//          totalRibaReceived = getRibaTotal();
//          double total = totalRibaReceived / 100;
//          totalRibaReceivedD = total;
//        });
//      });
//    });
//  }
//
//  void updateListRibaPaid(int userId) {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelRiba>> loanListFuture =
//      databaseHelper.getRibaListPaid(userId);
//      loanListFuture.then((ribaList) {
//        setState(() {
//          this.ribaList = ribaList;
//          this.count = ribaList.length;
//          totalRibaPaid = getRibaTotal();
//          int absolute = totalRibaPaid.abs();
//          double total = absolute / 100;
//          totalRibaPaidD = total;
//        });
//      });
//    });
//  }
//
//  int getRibaTotal() {
//    double totalAmountRiba = 0;
//    for (int i = 0; i <= ribaList.length - 1; i++) {
//      totalAmountRiba = totalAmountRiba + this.ribaList[i].amount;
//    }
//    return totalAmountRiba.round();
//  }
//
////-------------------------Loan Functions------------------------------------------------
//
//  void updateListViewBorrow(String table, String type, int userId) {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelLoan>> loanListFuture =
//      databaseHelper.getLoanList(table, type, userId);
//      loanListFuture.then((LoanList) {
//        setState(() {
//          this.loanList = LoanList;
//          this.count = LoanList.length;
//          totalBorrow = getloanTotal();
//          double total = totalBorrow / 100;
//          totalBorrowD = total;
//        });
//      });
//    });
//  }
//
//  void updateListViewLendSecure(String table, String type, int userId) {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelLoan>> loanListFuture =
//      databaseHelper.getLoanList(table, type, userId);
//      loanListFuture.then((loanList) {
//        setState(() {
//          this.loanList = loanList;
//          this.count = loanList.length;
//          totalLendSecure = getloanTotal();
//          double total = totalLendSecure / 100;
//          totalLendSecureD = total;
//        });
//      });
//    });
//  }
//
//  // functions for metal.................................................
//  void updateListViewLendInsecure(String table, String type, int userid) {
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelLoan>> cashListFuture =
//      databaseHelper.getLoanList(table, type, userid);
//      cashListFuture.then((lendinsecureList) {
//        setState(() {
//          this.loanList = lendinsecureList;
//          this.count = lendinsecureList.length;
//          totalLendInsecure = getloanTotal();
//          double total = totalLendInsecure / 100;
//          totalLendInsecureD = total;
//        });
//      });
//    });
//  }
//
//  void getUserAuthentication() async {
//    prefs = await SharedPreferences.getInstance();
//    String email; String password;
//    setState(() {
//      email = detailsUser.userEmail;
//      password = detailsUser.userEmail;
//    });
//    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//    dbFuture.then((database) {
//      Future<List<ModelUsers>> userListFuture = databaseHelper
//          .getUserAuthentication(email, password);
//      userListFuture.then((userList) {
//        setState(() {
//          this.userList = userList;
//          this.countGA = userList.length;
//          if(countGA!=0)
//          {
//            this.userId=this.userList[0].userId;
//            prefs?.setBool("isLoggedIn", true);
//            prefs?.setString("email", detailsUser.userEmail);
//            prefs?.setInt("userId", this.userId);
//            cashList = List<ModelCash>();
//            userList = List<ModelUsers>();
//            metalList = List<ModelMetal>();
//            settingList = List<ModelSetting>();
//            updateListViewSetting(this.userId);
//            updateListViewCash('cash', 'cashinhand', this.userId);
//            updateListViewCash('cash', 'cashinbank', this.userId);
//            updateListViewMetal('metal', 'gold', this.userId);
//            updateListViewMetal('metal', 'silver', this.userId);
//            updateListAllLoan(this.userId);
//            updateListAllRiba(this.userId);
//            updateListRibaPaid(this.userId);
//            updateListRibaReceived(this.userId);
//            updateListViewBorrow('loan', 'borrow', this.userId);
//            updateListViewLendSecure('loan', 'lendsecure', this.userId);
//            updateListViewLendInsecure('loan', 'lendinsecure', this.userId);
//            getAllTotal();
//          }
//        });
//        if(countGA==0) {
//          _save();
//        }
//      });
//    });
//  }
//  void _save() async {
//    prefs = await SharedPreferences.getInstance();
//    setState(() {
//      this.user.email = detailsUser.userEmail;
//      this.user.password = detailsUser.userEmail;
//      this.user.registrationDate = '12.12.2019';
//      this.user.age = 00;
//      this.user.isPaid = 'yes';
//      this.user.paymentDate = '12.12.2019';
//      this.user.city = 'Delhi';
//      this.user.pin = 000000;
//      this.user.familyId = 1;
//    });
//    int result;
//    if (this.countGA != 0) {
//      // Case 1: Update operation
//      result = await databaseHelper.updateUser(user);
//    } else {
//      // Case 2: Insert Operation
//      result = await databaseHelper.insertUser(user);
//      databaseHelper.getUserList();
//    }
//    getUserAuthentication();
//  }
//}
