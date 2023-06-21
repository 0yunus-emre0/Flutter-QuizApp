import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final String height = QuizScreenState().highscore.toString();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Container(
                             
                    child: const Text(
                      "Test Your Knowlage",
                      style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Sriracha',
                        ),
                      ),
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QuizScreen()),
                      );
                      if (result != null) {
                        int highscore = result as int;
                        // _highscore değeriyle yapılması gereken işlemleri yapabilirsiniz, örneğin UI'da güncelleyebilirsiniz.
                        print('En yüksek skor: $highscore');
                      }
                    },
                    child: const Text(
                      'Start Challange',
                      style: TextStyle(
                        fontFamily: 'Sriracha',
                        fontSize: 25.0,
                      ),
                      ),
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('About This App'),
                            content: const Text(
                              'This is a quiz application that you can test your knowlage. Just press to Start Challange button and answer questions. After answered 10 questions, you will see the result of your test. Good Luck!  Developer: Yunus Emre Akkoyun'
                              ),
                            actions: [
                              ElevatedButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'About This App',
                        style: TextStyle(
                        fontFamily: 'Sriracha',
                        fontSize: 20.0,
                      ),                  
                      ),
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Highscore'),
                            content: Text('En yüksek skor: 10/$height'),
                            actions: [
                              ElevatedButton(
                                child: const Text('Kapat'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Show Highscore',
                       style: TextStyle(
                        fontFamily: 'Sriracha',
                        fontSize: 20.0,
                      ),
                      ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
