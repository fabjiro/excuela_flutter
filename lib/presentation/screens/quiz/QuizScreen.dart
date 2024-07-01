import 'package:excuela_flutter/infrastructure/models/QuestionModel.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  // final List<Question> questions;

  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  String _selectedOption = '';

  final questions = [
    QuestionModel(
      questionText: 'cual es la capital de francia?',
      options: ['Paris', 'London', 'Rome', 'Berlin'],
      correctAnswer: 'Paris',
    ),
    QuestionModel(
      questionText: 'el cielo es azul?',
      options: ['Verdadero', 'Falso'],
      correctAnswer: 'Verdadero',
      isMultipleChoice: false,
    ),
  ];

  /// Advances to the next question in the quiz.
  ///
  /// If we are not at the last question, increments the current question index
  /// and clears the selected option. If we are at the last question, resets
  /// the current question index and the selected option.
  ///
  /// This function does not return anything.
  void _nextQuestion() {
    setState(() {
      // If we are not at the last question, increment the current question index
      // and clear the selected option.
      if (_currentQuestionIndex < questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOption = '';
      } else {
        // If we are at the last question, reset the current question index
        // and the selected option.
        _currentQuestionIndex = 0;
        _selectedOption = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen quiz'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentQuestion.questionText,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...currentQuestion.options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            );
          }).toList(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _selectedOption.isNotEmpty ? _nextQuestion : null,
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }
}
