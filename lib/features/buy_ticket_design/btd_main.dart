import 'package:lakhimpur_kheri/features/buy_ticket_design/home_page.dart';
import 'package:flutter/material.dart';


class BuyTicketDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SF Pro Display'),
      title: 'Buy Tickets',
      home: HomePage(),
    );
  }
}
