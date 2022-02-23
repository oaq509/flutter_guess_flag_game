// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:guess_flag/QuizScreen.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({required this.correctAnswers, required this.wrongAnswers});
   int correctAnswers;
   int wrongAnswers;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("النتيجة"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${this.widget.correctAnswers}: الإجابات الصحيحة",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "${this.widget.wrongAnswers}: الإجابات الخاطئة",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 35,),
            ElevatedButton(onPressed: () {
              setState(() {
                this.widget.correctAnswers = 0;
                this.widget.wrongAnswers = 0;


                Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()));
              });
            }, child: Text("اعادة", style: TextStyle(fontSize: 25),))
          ],
        ),
      ),
    );
  }
}
