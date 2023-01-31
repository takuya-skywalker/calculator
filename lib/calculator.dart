class Calculator {
  //1+2+3*4*5+6=69

  final List<String> stack = [];
  final List<String> opStack = [];
  final List<String> numStack = [];
  final List<String> convertedStack = [];

  void init() {
    stack.clear();
    opStack.clear();
    numStack.clear();
    convertedStack.clear();
  }

  void push(String value) {
    if (stack.isNotEmpty &&
        value.allMatches('+|-|*|/').isNotEmpty &&
        stack.last.allMatches('+|-|*|/').isNotEmpty) {
      stack.removeLast();
    }
    stack.add(value);
    print('push : ' + value);
  }

  String per(String value) {
    final number = double.parse(value) * 0.01;

    if (number - number.toInt() == 0) {
      return number.toInt().toString();
    } else {
      return number.toString();
    }
  }

  String sign(String value) {
    if (value == '0') {
      return '-0';
    }

    if (value == '-0') {
      return '0';
    }

    final number = double.parse(value) * -1;
    if (number - number.toInt() == 0) {
      return number.toInt().toString();
    } else {
      return number.toString();
    }
  }

  String calculateFromStack() {
    String number = '';
    String operator = '';
    if (stack.isEmpty) {
      return '0';
    }

    for (String element in stack) {
      if (element.allMatches('+|-|*|/').isNotEmpty) {
        operator = element;
      } else {
        if (number.isEmpty) {
          number = element;
        } else {
          number =
              calculate(double.parse(number), double.parse(element), operator)
                  .toString();
          operator = '';
        }
      }
    }

    //桁数調整
    if (double.parse(number) - double.parse(number).toInt() == 0) {
      print('calc from stack : ' + double.parse(number).toInt().toString());
      return double.parse(number).toInt().toString();
    } else {
      print('calc from stack : ' + number);
      return number;
    }
  }

  String calculateFromConvertedStack() {
    String number = '';

    final List<String> nStack = [];

    for (String element in convertedStack) {
      if (element.allMatches('+|-|*|/').isNotEmpty) {
        if (nStack.length == 1) {
        } else {
          final num1 = double.parse(nStack[nStack.length - 2]);
          final num2 = double.parse(nStack[nStack.length - 1]);
          nStack.removeLast();
          nStack.removeLast();
          nStack.add(calculate(num1, num2, element).toString());
        }
      } else {
        nStack.add(element);
      }
    }
    number = nStack.first;
    convertedStack.add(number);

    //桁数調整
    if (double.parse(number) - double.parse(number).toInt() == 0) {
      print('calc from converted stack : ' +
          double.parse(number).toInt().toString());
      return double.parse(number).toInt().toString();
    } else {
      print('calc from converted stack : ' + number);
      return number;
    }
  }

  double calculate(double num1, double num2, String op) {
    switch (op) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case '*':
        return num1 * num2;
      case '/':
        return num1 / num2;
    }
    return 0;
  }

  void convert() {
    opStack.clear();
    numStack.clear();

    //通常の配列から逆ポーランド記法の配列を取得
    //TODO: 処理の効率化できそう！！

    for (String element in stack) {
      //演算子検索
      if (element.allMatches('+|-|*|/').isNotEmpty) {
        //演算子の格納
        if (opStack.isEmpty) {
          opStack.add(element);
        } else {
          //優先順位の高い演算子の場合はスタック
          if (opStack.last.allMatches('+|-').isNotEmpty &&
              element.allMatches('*|/').isNotEmpty) {
            opStack.add(element);
          }
          //優先順位の低い演算子の場合は出力
          else if (opStack.last.allMatches('*|/').isNotEmpty &&
              element.allMatches('+|-').isNotEmpty) {
            for (int index = opStack.length - 1; index >= 0; index--) {
              convertedStack.add(opStack[index]);
            }
            opStack.clear();
            opStack.add(element);
          }
          //乗算
          else if (opStack.last.allMatches('*|/').isNotEmpty &&
              element.allMatches('*|/').isNotEmpty) {
            for (int index = opStack.length - 1; index >= 0; index--) {
              convertedStack.add(opStack[index]);
            }
            opStack.clear();
            opStack.add(element);
          }
          //加算・引き算
          else if (opStack.last.allMatches('+|-').isNotEmpty &&
              element.allMatches('+|-').isNotEmpty) {
            for (int index = opStack.length - 1; index >= 0; index--) {
              convertedStack.add(opStack[index]);
            }
            opStack.clear();
            opStack.add(element);
          } else {
            convertedStack.add(element);
          }
        }
      } else {
        convertedStack.add(element);
      }
    }
    for (int index = opStack.length - 1; index > -1; index--) {
      convertedStack.add(opStack[index]);
    }
    print('convertedStack is ' + convertedStack.toString());
  }
}
