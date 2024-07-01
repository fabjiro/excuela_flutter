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

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOption = '';
      } else {
        // Aquí puedes mostrar los resultados o reiniciar el cuestionario
        // por simplicidad, solo reiniciamos el cuestionario
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
