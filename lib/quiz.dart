import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/qution_screen.dart';
import 'package:adv_basics/result_screen.dart';
import 'package:adv_basics/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswer =
      []; // this variable store the all selected answer
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswer
        .add(answer); //this line code updated the selectedAnswer variable

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswer = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenwidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenwidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      ); //pass the chooseAnswer value in QuestionsScreen file
    }

    if (activeScreen == 'results-screen') {
      screenwidget = ResultsScreen(
        chosenAnswers: selectedAnswer,
        onRestart: restartQuiz,
      ); // add the ResultsScreen value add in the activeScreen
    }

    return MaterialApp(
        home: Scaffold(
      body: Container(
          constraints: const BoxConstraints
              .expand(), // Make the Container fill the entire screen
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 58, 7, 145),
              Color.fromARGB(255, 107, 15, 168),
            ], begin: Alignment.topLeft, end: Alignment.topRight),
          ),
          child: screenwidget),
    ));
  }
}
