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
  String value = '0';

  //valueを変更する関数
  void inputNumText(String letter) {
    setState(() {
      if (value == '0') {
        value = letter;
      } else {
        value += letter;
      }
    });
  }

  //小数点を入力する関数
  void inputDotText() {
    setState(() {
      if (value.contains(',') == true) {
        value = value;
      } else {
        value = '$value,';
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
              CalcuratorButton(
                  title: 'C',
                  theme: CalcuratorButtonTheme.other,
                  onPressed: () => clearNumText()),
              CalcuratorButton(
                title: '±',
                theme: CalcuratorButtonTheme.other,
                onPressed: () {},
              ),
              CalcuratorButton(
                title: '%',
                theme: CalcuratorButtonTheme.other,
                onPressed: () {},
              ),
              CalcuratorButton(
                title: '÷',
                theme: CalcuratorButtonTheme.operator,
                onPressed: () {
                  setState(() {
                    calculator.addValue(value);
                    calculator.addValue('/');
                    value = '0';
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
                    calculator.addValue(value);
                    calculator.addValue('*');
                    value = '0';
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
                    calculator.addValue(value);
                    calculator.addValue('-');
                    value = '0';
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
                    calculator.addValue(value);
                    calculator.addValue('+');
                    value = '0';
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
                    calculator.addValue(value);
                    calculator.calculate();
                    value = calculator.answer ?? '0';
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
