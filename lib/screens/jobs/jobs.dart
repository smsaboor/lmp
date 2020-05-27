import 'package:flutter/material.dart';




class Jobs extends StatefulWidget {
  Jobs();
  @override
  State<StatefulWidget> createState() {
    return JobsState();
  }
}
class JobsState extends State<Jobs> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

//    ListView getRibaReceivedList() {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body(){
    return new ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                child: Column(),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0x22ff3a5a), Color(0x22fe494d)])),
              ),
            ),
            ClipPath(
              child: Container(
                child: Column(),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0x44ff3a5a), Color(0x44fe494d)])),
              ),
            ),
            ClipPath(
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Icon(
                      Icons.account_balance,
                      color: Colors.white,
                      size: 60,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Lakhimpur Kheri",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30),
                    ),
                  ],
                ),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xffff3a5a), Color(0xfffe494d)])),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}