import 'dart:convert';
import 'package:flutter/material.dart';
import 'question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);


  
  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int score = 0;
  int highscore = 10;
  String _resultText = '';

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    String jsonData = await DefaultAssetBundle.of(context).loadString('data.json');
    List<dynamic> jsonList = json.decode(jsonData);

    List<Question> questions = [];
    for (var jsonItem in jsonList) {
      Question question = Question.fromJson(jsonItem);
      questions.add(question);
    }
  

    setState(() {
      _questions = questions;
      _questions.shuffle();
      _questions = _questions.take(10).toList();
    });
  }

  

  void _checkAnswer(int selectedIndex) {
    if (selectedIndex == _questions[_currentQuestionIndex].answerIndex) {
      setState(() {
        score++;
      });
    }

    _showNextQuestion();
  }

  void _showNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      if(score > highscore){
        highscore = score;
      }

      if (score == 10) {
        _resultText = 'Congratulations! You are a Genius!';
      } 
      else if (score > 8){
        _resultText = 'Quiz Completed. Congratulations! This is a good score.';
      }
      else if (score <= 8 && score >= 6){
        _resultText = 'Quiz Completed. Congratulations! Your knowlage is not bad.';
      }
      else if (score <= 5 && score >=1 ){
        _resultText = 'Quiz Completed. You have to work harder :(';
      }
      else {
        _resultText = 'Quiz Complated. Congratulations! All answers are wrong.';
      }

      
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_resultText),
          content: Text('Your Score: $score / ${_questions.length}'),
          actions: [
            TextButton(
              child: const Text('Main Menu'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
            TextButton(
              child: const Text('Restart'),
              onPressed: () {
                setState(() {
                  _currentQuestionIndex = 0;
                  score = 0;
                  _resultText = '';
                  _questions.shuffle();
                  _questions = _questions.take(10).toList();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Question currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img/background03.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: Text(
                  currentQuestion.question,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 150),
              ...currentQuestion.choices.map((choice) {
                int choiceIndex = currentQuestion.choices.indexOf(choice);
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _checkAnswer(choiceIndex),
                      child: Text(choice),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
