import 'package:flutter/material.dart';
import 'dart:async';
import 'calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String value = '0';

  void addNumText(String letter) {
    setState(() {
      if (value == '0') {
        value = letter;
      } else if (letter == '=') {
        value = '';
        var ans = Calculator.execute();
        controller.sink.add(ans);
      } else {
        value += letter;
      }

    });
  }

  void dotText() {
    setState(() {
      if(value.contains('.') == true){
        value = value;
      }else{
        value = '$value.';
      }
    });
  }

  void clearNumText() {
    setState(() {
      value = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    NumButton numButton1 =
    NumButton(buttonNum: '1', onPressed: () => addNumText('1'));
    NumButton numButton2 =
    NumButton(buttonNum: '2', onPressed: () => addNumText('2'));
    NumButton numButton3 =
    NumButton(buttonNum: '3', onPressed: () => addNumText('3'));
    NumButton numButton4 =
    NumButton(buttonNum: '4', onPressed: () => addNumText('4'));
    NumButton numButton5 =
    NumButton(buttonNum: '5', onPressed: () => addNumText('5'));
    NumButton numButton6 =
    NumButton(buttonNum: '6', onPressed: () => addNumText('6'));
    NumButton numButton7 =
    NumButton(buttonNum: '7', onPressed: () => addNumText('7'));
    NumButton numButton8 =
    NumButton(buttonNum: '8', onPressed: () => addNumText('8'));
    NumButton numButton9 =
    NumButton(buttonNum: '9', onPressed: () => addNumText('9'));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 100,
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: const TextStyle(fontSize: 75, color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MarkButton(
                  buttonMark: 'C',
                  backGroundColor: Colors.white38,
                  onPressed: () => clearNumText()),
              const MarkButton(buttonMark: '±', backGroundColor: Colors.white38),
              const MarkButton(buttonMark: '%', backGroundColor: Colors.white38),
              const MarkButton(buttonMark: '÷', backGroundColor: Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              numButton7,
              numButton8,
              numButton9,
              const MarkButton(buttonMark: '×', backGroundColor: Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              numButton4,
              numButton5,
              numButton6,
              const MarkButton(buttonMark: '－', backGroundColor: Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              numButton1,
              numButton2,
              numButton3,
              const MarkButton(buttonMark: '＋', backGroundColor: Colors.orange),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 180,
                height: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white12,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () => addNumText('0'),
                  child: Container(
                    width: double.infinity,
                    alignment: const Alignment(-0.75, 0),
                    child: Text(
                      0.toString(),
                      style: const TextStyle(
                        fontSize: 38,
                      ),
                    ),
                  ),
                ),
              ),
              MarkButton(
                  buttonMark: '.',
                  backGroundColor: Colors.white12,
                  onPressed: () => dotText()),
              const MarkButton(buttonMark: '=', backGroundColor: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
  static final controller = StreamController<String>.broadcast();

  @override

  void initState() {
    super.initState();
    controller.stream.listen((event) => addNumText(event));
    controller.stream.listen((event) => Calculator.button(event));
  }
}

class NumButton extends StatefulWidget {
  const NumButton({Key? key, required this.buttonNum, required this.onPressed})
      : super(key: key);
  final String buttonNum;
  final VoidCallback onPressed;

  @override
  State<NumButton> createState() => _NumButtonState();
}

class _NumButtonState extends State<NumButton> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white12,
          shape: const CircleBorder(),
        ),
        onPressed: (){widget.onPressed;},
        child: Text(
          widget.buttonNum,
          style: const TextStyle(
            fontSize: 38,
          ),
        ),
      ),
    );
  }
}

class MarkButton extends StatefulWidget {
  const MarkButton(
      {Key? key,
        required this.buttonMark,
        required this.backGroundColor,
        this.onPressed})
      : super(key: key);
  final String buttonMark;
  final Color backGroundColor;
  final VoidCallback? onPressed;

  @override
  State<MarkButton> createState() => _MarkButtonState();
}

class _MarkButtonState extends State<MarkButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backGroundColor,
          shape: const CircleBorder(),
        ),
        onPressed: widget.onPressed ?? () {},
        child: Text(
          widget.buttonMark,
          style: const TextStyle(
            fontSize: 38,
          ),
        ),
      ),
    );
  }
}

