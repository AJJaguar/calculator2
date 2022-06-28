import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

var question = "";
var answer = "";

class _MainState extends State<Main> {
  final List<String> buttons = [
    'C',
    '()',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '+/-',
    '0',
    '.',
    '='
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFFFFEFF0),
            body: Column(
              children: [
                Expanded(
                    child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                      SizedBox(height: 20),
                      Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.centerRight,
                          child: Text(
                            question,
                            style: TextStyle(color: Colors.black),
                          )),
                      Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.centerRight,
                          child: Text(question)),
                    ]))),
                SizedBox(
                    height: 80,
                    child: Column(children: [
                      Row(children: [
                        Row(
                          children: [
                            Container(
                              width: 250,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.punch_clock_outlined),
                                  Icon(Icons.rule_rounded),
                                  Icon(Icons.crop_square_sharp),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  question = question.substring(
                                      0, question.length - 1);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: IconButton(
                                    onPressed: () {}, icon: Icon(Icons.clear)),
                              ),
                            )
                          ],
                        ),
                      ]),
                      SizedBox(height: 5),
                      Divider(thickness: 1, color: Color(0xffC4AEAF)),
                    ])),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4, mainAxisExtent: 95),
                            itemCount: buttons.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return Button(
                                  buttonTapped: () {
                                    setState(() {
                                      question = "";
                                    });
                                  },
                                  ButtonText: buttons[index],
                                  Textcolor: Color(0xffB53D78),
                                  ButtonColor: Color(0xffE0B2B2),
                                );
                              } else if (index == buttons.length - 1) {
                                return Button(
                                  ButtonText: buttons[index],
                                  Textcolor: Colors.white,
                                  ButtonColor: Color(0xffFA6D1E),
                                );
                              } else {
                                return Button(
                                  buttonTapped: () {
                                    setState(() {
                                      question += buttons[index];
                                    });
                                  },
                                  ButtonText: buttons[index],
                                  Textcolor: isoperator(buttons[index])
                                      ? Color(0xff5094DD)
                                      : Colors.black,
                                  ButtonColor: Color(0xffE0B2B2),
                                );
                              }
                            }),
                      ),
                    )
                    // ],

                    // )
                    ),
              ],
            )));
  }

  bool isoperator(String x) {
    if (x == '()' || x == '%' || x == '/' || x == 'x' || x == '-' || x == '+')
      return true;
    return false;
  }
}

class Button extends StatelessWidget {
  final String ButtonText;
  final ButtonColor;
  final Textcolor;
  final buttonTapped;
  const Button({
    required this.ButtonText,
    this.ButtonColor,
    this.Textcolor,
    this.buttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: ButtonColor, borderRadius: BorderRadius.circular(45)),
          child: Center(
              child: Text(
            ButtonText,
            style: TextStyle(
              fontSize: 40,
              color: Textcolor,
            ),
          )),
        ),
      ),
    );
  }
}
