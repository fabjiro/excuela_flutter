class QuestionModel {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final bool isMultipleChoice;

  QuestionModel({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.isMultipleChoice = true,
  });
}