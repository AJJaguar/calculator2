import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // title: 'First Method',
          // // You can use the library anywhere in the app even in theme
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          //   textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          // ),
          home: child,
        );
      },
      child: const Main(),
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
var ans = "";
var number = "";

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
    return Scaffold(
        backgroundColor: Color(0xFFFFEFF0),
        body: Column(
          children: [
            SizedBox(
                height: 330.h,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // SizedBox(height: 20),
                      Expanded(
                        child: Container(
                            // color: Colors.red,
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.bottomRight,
                            child: Text(
                              question,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            )),
                      ),
                      Expanded(
                        child: Container(
                            // color: Colors.blue,
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.centerRight,
                            child: Text(
                              answer,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 52,
                            ).r,
                            child: SizedBox(
                              width: 120.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                      'lib/images/Time Clock Nine To Five.png'),
                                  Image.asset('lib/images/Ruler.png'),
                                  Image.asset('lib/images/Calculator App.png'),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                question =
                                    question.substring(0, question.length - 1);

                                // _mathexpression();

                                ans = answer;
                                answer = ans;
                              });
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(right: 50).r,
                                child: Image.asset(
                                    'lib/images/Keyboard Delete.png')),
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ])),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ).r,
              child: Divider(
                thickness: 1.h,
                color: Color(0xffB19898),
              ),
            ),
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22, vertical: 5).r,
              child: Container(
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, mainAxisExtent: 92.r),
                      itemCount: buttons.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Button(
                            buttonTapped: () {
                              setState(() {
                                question = "";
                                answer = "";
                              });
                            },
                            ButtonText: buttons[index],
                            Textcolor: Color(0xffB53D78),
                            ButtonColor: Color(0xffE0B2B2),
                          );
                        } else if (index == buttons.length - 1) {
                          return Button(
                            buttonTapped: () {
                              setState(() {
                                _mathexpression();
                              });
                            },
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
              ),
            )
                // ],

                // )
                ),
          ],
        ));
  }

  bool isoperator(String x) {
    if (x == '()' || x == '%' || x == '/' || x == 'x' || x == '-' || x == '+')
      return true;
    return false;
  }

  void _mathexpression() {
    String finalQuestion = question;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();

    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    // userAnswer = eval.toString() + "  " + userNumber;
    answer = eval.toString();
    int i = answer.length - 1;
    if (answer[i] == '0' && answer[i - 1] == '.')
      answer = answer.substring(0, i - 1);

    // answer = answer.substring(1,)
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
        padding: const EdgeInsets.all(8.0).r,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.r),
          child: Container(
            color: ButtonColor,
            child: Center(
                child: Text(
              ButtonText,
              style: TextStyle(
                fontFamily: 'Roboto',
                // fontFamily: 'Splash',
                fontSize: 36.sp,
                fontWeight: FontWeight.w300,
                color: Textcolor,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
