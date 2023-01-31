import 'package:calculator/calculator.dart';
import 'package:calculator/view/components/calculator_button.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  Calculator calculator = Calculator();

  //計算機に実際に表示される値
  String text = '0';
  String value = '0';
  bool isOperation = false;

  //valueを変更する関数
  void inputNumText(String letter) {
    isOperation = false;
    setState(() {
      if (value.length >= 9) {
        return;
      }

      if (value == '0') {
        value = letter;
      } else if (value == '-0') {
        value = '-$letter';
      } else {
        value += letter;
      }

      if (value != text) {
        text = value;
      }
    });
  }

  //符号入力
  void inputSign() {
    setState(() {
      value = calculator.sign(value);
      text = value;
    });
  }

  //パーセント
  void inputPer() {
    setState(() {
      value = calculator.per(value);
      text = value;
    });
  }

  //小数点を入力する関数
  void inputDotText() {
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
      calculator.init();
      value = '0';
      text = '0';
      isOperation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                text,
                style: const TextStyle(fontSize: 75, color: Colors.white),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalcuratorButton(
                  title: 'C',
                  theme: CalcuratorButtonTheme.other,
                  onPressed: () => clearNumText()),
              CalcuratorButton(
                title: '±',
                theme: CalcuratorButtonTheme.other,
                onPressed: inputSign,
              ),
              CalcuratorButton(
                title: '%',
                theme: CalcuratorButtonTheme.other,
                onPressed: inputPer,
              ),
              CalcuratorButton(
                title: '÷',
                theme: CalcuratorButtonTheme.operator,
                onPressed: () {
                  setState(() {
                    if (!isOperation) {
                      calculator.push(value);
                    }
                    isOperation = true;
                    calculator.push('/');
                    value = '0';
                    text = calculator.calculateFromStack();
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalcuratorButton(
                  title: '7',
                  theme: CalcuratorButtonTheme.number,
                  onPressed: () => inputNumText('7')),
              CalcuratorButton(
                  title: '8',
                  theme: CalcuratorButtonTheme.number,
                  onPressed: () => inputNumText('8')),
              CalcuratorButton(
                  title: '9',
                  theme: CalcuratorButtonTheme.number,
                  onPressed: () => inputNumText('9')),
              CalcuratorButton(
                title: 'x',
                theme: CalcuratorButtonTheme.operator,
                onPressed: () {
                  setState(() {
                    if (!isOperation) {
                      calculator.push(value);
                    }
                    isOperation = true;
                    calculator.push('*');
                    value = '0';
                    text = calculator.calculateFromStack();
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalcuratorButton(
                  title: '4',
                  theme: CalcuratorButtonTheme.number,
                  onPressed: () => inputNumText('4')),
              CalcuratorButton(
                  title: '5',
                  theme: CalcuratorButtonTheme.number,
                  onPressed: () => inputNumText('5')),
              CalcuratorButton(
                  title: '6',
                  theme: CalcuratorButtonTheme.number,
                  onPressed: () => inputNumText('6')),
              CalcuratorButton(
                title: '-',
                theme: CalcuratorButtonTheme.operator,
                onPressed: () {
                  setState(() {
                    if (!isOperation) {
                      calculator.push(value);
                    }
                    isOperation = true;
                    calculator.push('-');
                    value = '0';
                    text = calculator.calculateFromStack();
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalcuratorButton(
                  title: '1',
                  theme: CalcuratorButtonTheme.number,
                  onPressed: () => inputNumText('1')),
              CalcuratorButton(
                  title: '2',
                  theme: CalcuratorButtonTheme.number,
                  onPressed: () => inputNumText('2')),
              CalcuratorButton(
                  title: '3',
                  theme: CalcuratorButtonTheme.number,
                  onPressed: () => inputNumText('3')),
              CalcuratorButton(
                title: '+',
                theme: CalcuratorButtonTheme.operator,
                onPressed: () {
                  setState(() {
                    if (!isOperation) {
                      calculator.push(value);
                    }
                    isOperation = true;
                    calculator.push('+');
                    value = '0';
                    text = calculator.calculateFromStack();
                  });
                },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalcuratorButton(
                  title: '0',
                  theme: CalcuratorButtonTheme.number,
                  onPressed: () => inputNumText('0')),
              CalcuratorButton(
                  title: ',',
                  theme: CalcuratorButtonTheme.number,
                  onPressed: () => inputDotText()),
              CalcuratorButton(
                title: '=',
                theme: CalcuratorButtonTheme.operator,
                onPressed: () {
                  setState(() {
                    calculator.push(value);
                    calculator.convert();
                    value = calculator.calculateFromConvertedStack();
                    text = value;
                    calculator.init();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
