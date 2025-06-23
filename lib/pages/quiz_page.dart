import 'package:flutter/material.dart';
import 'dart:math';

import '../models/country.dart';
import '../services/country_service.dart';
import '../components/flag_option.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final CountryService _countryService = CountryService();

  List<Country> _allCountries = [];
  List<Country> _remainingCountries = [];

  late Country _correctCountry;
  List<Country> _options = [];
  bool _isLoading = true;
  bool _answered = false;
  String? _selectedAnswer;
  int _score = 0;
  int _questionCount = 0;
  final int _maxQuestions = 10;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    final countries = await _countryService.fetchCountries();
    setState(() {
      _allCountries = countries;
      _remainingCountries = List.from(countries);
      _generateQuestion();
      _isLoading = false;
    });
  }

  void _generateQuestion() {
    setState(() {
      _answered = false;
      _selectedAnswer = null;

      final random = Random();
      _correctCountry = _remainingCountries
          .removeAt(random.nextInt(_remainingCountries.length));

      final optionsSet = <Country>{_correctCountry};
      while (optionsSet.length < 4) {
        optionsSet.add(_allCountries[random.nextInt(_allCountries.length)]);
      }

      _options = optionsSet.toList()..shuffle();
    });
  }

  void _handleAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _answered = true;

      if (answer == _correctCountry.name) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionCount++;
      if (_questionCount >= _maxQuestions) {
        _showFinalScore();
      } else {
        _generateQuestion();
      }
    });
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Fim de Jogo!'),
        content: Text('Sua pontuação: $_score/$_maxQuestions'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _restartGame();
            },
            child: const Text('Jogar Novamente'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Voltar para o Home
            },
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }

  void _restartGame() {
    setState(() {
      _remainingCountries = List.from(_allCountries);
      _score = 0;
      _questionCount = 0;
      _generateQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta ${_questionCount + 1} de $_maxQuestions'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'De qual país é essa bandeira?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Image.network(
            _correctCountry.flagUrl,
            height: 150,
            width: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          ..._options.map((country) {
            final isCorrect = country.name == _correctCountry.name;
            final isSelected = _selectedAnswer == country.name;

            Color? tileColor;
            if (_answered && isSelected) {
              tileColor = isCorrect ? Colors.green[300] : Colors.red[300];
            } else if (_answered && isCorrect) {
              tileColor = Colors.green[100];
            }

            return Container(
              color: tileColor,
              child: FlagOption(
                optionText: country.name,
                onTap: _answered
                    ? () {}
                    : () {
                        _handleAnswer(country.name);
                      },
              ),
            );
          }).toList(),
          const Spacer(),
          if (_answered)
            ElevatedButton(
              onPressed: _nextQuestion,
              child: const Text('Próxima Pergunta'),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
