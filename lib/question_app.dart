import 'package:flutter/material.dart';

class Question {
  final String clue;
  final String answer;
  Question(this.clue, this.answer);
}

class QuestionApp extends StatelessWidget {
  final List<Question> questions = [
    Question("What has a head and a tail, but no body?", "Coin"),
    Question(
        "What starts with an E, ends with an E, but only contains one letter?",
        "Envelope"),
    Question("What is full of holes but still holds water?", "Sponge"),
    Question(
        "I am not a living thing, but i need air and oxygen to live. I will engulf everything ",
        "fire"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treasure Hunt Game',
      home: HomeScreen(questions),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 255, 221, 109),
        accentColor: Color.fromARGB(255, 249, 64, 2),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Question> questions;

  HomeScreen(this.questions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Treasure Hunt Game',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/map.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/map.png",
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to the Treasure Hunt Game!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClueScreen(questions),
                    ),
                  );
                },
                child: Text('Start Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClueScreen extends StatefulWidget {
  final List<Question> questions;

  ClueScreen(this.questions);

  @override
  _ClueScreenState createState() => _ClueScreenState();
}

class _ClueScreenState extends State<ClueScreen> {
  int _questionIndex = 0;
  final TextEditingController _answerController = TextEditingController();
  bool _isCorrect = false;

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = widget.questions[_questionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clue Screen',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Clue: ${currentQuestion.clue}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                hintText: 'Enter your answer here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String answer = _answerController.text.toLowerCase();
                if (answer == currentQuestion.answer.toLowerCase()) {
                  _isCorrect = true;
                } else {
                  _isCorrect = false;
                }
                _answerController.clear();
                if (_questionIndex < widget.questions.length - 1) {
                  setState(() {
                    _questionIndex++;
                  });
                  if (_isCorrect) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Congratulations!'),
                          content: Text('You found the treasure!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Next Clue'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Sorry, try again.'),
                          content: Text('That is not the correct answer.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  if (_isCorrect) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalScreen(),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Sorry, try again.'),
                          content: Text('That is not the correct answer.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class FinalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Congratulations!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green[100],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/IU.jpg",
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20),
              Text(
                'You have completed the treasure hunt!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                },
                child: Text('Play Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
