import 'package:lakhimpur_kheri/screens/health_n_fitness/bmi_calculator/input_page/input_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'styles.dart';
class BmiMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primaryColor: mainBlue,
        fontFamily: 'SF Pro Display',
      ),
      home: InputPage(),
    );
  }
}
