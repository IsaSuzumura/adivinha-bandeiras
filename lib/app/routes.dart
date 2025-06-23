import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/quiz_page.dart';

class Routes {
  static const String home = '/';
  static const String quiz = '/quiz';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomePage(),
      quiz: (context) => const QuizPage(),
    };
  }
}
