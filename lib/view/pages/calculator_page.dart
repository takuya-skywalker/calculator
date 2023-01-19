import 'package:calculator2/calculator.dart';
import 'package:calculator2/view/components/mark_button.dart';
import 'package:calculator2/view/components/num_button.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  Calculator calculator = Calculator();

  //計算機に実際に表示される値
  String value = '0';

  //valueを変更する関数
  void addNumText(String letter) {
    setState(() {
      if (value == '0') {
        value = letter;
      } else {
        value += letter;
      }
    });
  }

  //小数点を入力する関数
  void dotText() {
    setState(() {
      if (value.contains('.') == true) {
        value = value;
      } else {
        value = '$value.';
      }
    });
  }

  //valueを0にする関数
  void clearNumText() {
    setState(() {
      calculator.clear();
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

    MarkButton plusButton = MarkButton(
      buttonMark: '+',
      backGroundColor: Colors.orange,
      onPressed: () {
        setState(() {
          calculator.addValue(value);
          calculator.addValue('+');
          value = '0';
        });
      },
    );

    MarkButton minusButton = MarkButton(
      buttonMark: '-',
      backGroundColor: Colors.orange,
      onPressed: () {
        setState(() {
          calculator.addValue(value);
          calculator.addValue('-');
          value = '0';
        });
      },
    );

    MarkButton multiButton = MarkButton(
      buttonMark: '×',
      backGroundColor: Colors.orange,
      onPressed: () {
        setState(() {
          calculator.addValue(value);
          calculator.addValue('*');
          value = '0';
        });
      },
    );

    MarkButton divButton = MarkButton(
      buttonMark: '÷',
      backGroundColor: Colors.orange,
      onPressed: () {
        setState(() {
          calculator.addValue(value);
          calculator.addValue('/');
          value = '0';
        });
      },
    );

    MarkButton equalButton = MarkButton(
      buttonMark: '=',
      backGroundColor: Colors.orange,
      onPressed: () {
        setState(() {
          calculator.addValue(value);
          calculator.calculate();
          value = calculator.answer ?? '0';
        });
      },
    );

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
              const MarkButton(
                  buttonMark: '±', backGroundColor: Colors.white38),
              const MarkButton(
                  buttonMark: '%', backGroundColor: Colors.white38),
              divButton,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              numButton7,
              numButton8,
              numButton9,
              multiButton,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              numButton4,
              numButton5,
              numButton6,
              minusButton,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              numButton1,
              numButton2,
              numButton3,
              plusButton,
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
              equalButton,
            ],
          ),
        ],
      ),
    );
  }
}
