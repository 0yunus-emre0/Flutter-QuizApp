class Question {
  String question;
  List<String> choices;
  int answerIndex;

  Question({required this.question, required this.choices, required this.answerIndex});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      choices: List<String>.from(json['choices']),
      answerIndex: json['answerIndex'],
    );
  }
}
