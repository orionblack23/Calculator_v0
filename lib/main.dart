import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import './calculator_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'X',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  String userQueston = '';
  String questionAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQueston,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        questionAnswer,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          // clear button
                          return CalculatorButton(
                            buttonTap: () {
                              setState(() {
                                userQueston = '';
                                questionAnswer = '';
                              });
                            },
                            txt: buttons[index],
                            txtColor: Colors.white,
                            bgColor: Colors.green,
                          );
                        } else if (index == 1) {
                          // delete button
                          return CalculatorButton(
                            buttonTap: () {
                              setState(() {
                                if (userQueston.length <= 0) {
                                  return;
                                }
                                userQueston = userQueston.substring(
                                    0, userQueston.length - 1);
                              });
                            },
                            txt: buttons[index],
                            txtColor: Colors.white,
                            bgColor: Colors.red,
                          );
                        } else if (index == buttons.length - 1) {
                          // equal button
                          return CalculatorButton(
                            buttonTap: () {
                              setState(() {
                                equalPress();
                              });
                            },
                            txt: buttons[index],
                            txtColor: Colors.white,
                            bgColor: Colors.deepPurple,
                          );
                        } else {
                          return CalculatorButton(
                            buttonTap: () {
                              setState(() {
                                userQueston += buttons[index];
                              });
                            },
                            txt: buttons[index],
                            txtColor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.deepPurple,
                            bgColor: isOperator(buttons[index])
                                ? Colors.deepPurple
                                : Colors.deepPurple[50],
                          );
                        }
                      }),
                ),
              ),
            ),
            flex: 5,
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == 'X' || x == '+' || x == '/' || x == '-') {
      return true;
    }
    return false;
  }

  void equalPress() {
    String finalQuestion = userQueston;
    finalQuestion = finalQuestion.replaceAll('X', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    questionAnswer = eval.toString();
  }
}
