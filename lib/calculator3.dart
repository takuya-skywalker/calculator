import 'dart:async';
import 'package:flutter/material.dart';
import 'calculator4.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const TextField(),
                const Keyboard(),
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
                        onPressed: () {},
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
                    const BottomButton(buttonMark: '.',
                      backGroundColor: Colors.white12,),
                    const BottomButton(buttonMark: '=',
                      backGroundColor: Colors.orange),
                  ],
                ),
              ],
            )
        )
    );
  }
}

class TextField extends StatefulWidget {
  const TextField({super.key});

  @override
  State<TextField> createState() => _TextFieldState();
}
class _TextFieldState extends State<TextField> {
  String _expression = '';
  void updateText(String letter){
    setState(() {
      if(letter == 'C') {
        _expression = '';
      } else if (letter == '='){
        _expression='';
        var ans = Calculator.execute();
        controller.sink.add(ans);
      } else {
        _expression += letter;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            _expression,
            style: const TextStyle(fontSize: 75, color: Colors.white),
          ),
        )
    );
  }
  static final controller = StreamController<String>.broadcast();
  @override
  void initState() {
    super.initState();
    controller.stream.listen((event) => updateText(event));
    controller.stream.listen((event) => Calculator.getKey(event));
  }
}

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Center(
            child: Container(
              color: const Color(0xff87cefa),
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 3.0,
                children: [
                  'AC', '±', '%', '÷',
                  '7', '8', '9', '×'
                  '4', '5', '6', '－',
                  '1', '2', '3', '＋',
                  '0', '.', '=',
                ].map((key) {
                  return GridTile(
                    child: Button(key),
                  );

                }).toList(),
              ),
            )
        )
    );
  }
}

class Button extends StatelessWidget {
  const Button(this._key, this._backgroundColor,{super.key});
  final Color _backgroundColor;
  final String _key;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor,
          shape: const CircleBorder(),
        ),
        onPressed: (){
          _TextFieldState.controller.sink.add(_key);
        },
        child: Text(
          _key,
          style: const TextStyle(
            fontSize: 38,
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton(
      {Key? key, required this.buttonMark, required this.backGroundColor,
      }) : super(key: key);
  final String buttonMark;
  final Color backGroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backGroundColor,
          shape: const CircleBorder(),
        ),
        onPressed: () {},
        child: Text(
          buttonMark,
          style: const TextStyle(
            fontSize: 38,
          ),
        ),
      ),
    );
  }
}
