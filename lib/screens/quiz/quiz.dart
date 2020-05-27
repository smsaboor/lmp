import 'package:flutter/material.dart';
import 'package:lakhimpur_kheri/screens/quiz/quiz_splash.dart';

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quizstar",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: QuizSplashScreen(),
    );
  }
}