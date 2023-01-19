import 'package:math_expressions/math_expressions.dart';

class Calculator {
  final List<String> values = [];
  String? answer;

  void addValue(String value) {
    values.add(value);
  }

  void addMarks(String mark) {
    values.add(mark);
  }

  void clear() {
    values.clear();
    answer = null;
  }

  void calculate() {
    Parser parser = Parser();
    String formula = '';

    for (final element in values) {
      formula = formula + element.toString();
    }

    Expression expression = parser.parse(formula);
    answer =
        expression.evaluate(EvaluationType.REAL, ContextModel()).toString();
    // int index = 0;
    // double? tempValue;

    // for (var element in values) {
    //   if (answer != null) {
    //     tempValue = answer;
    //   }

    //   if (tempValue == null) {
    //     tempValue = element;
    //   } else {
    //     switch (marks[index]) {
    //       case '+':
    //         answer = tempValue + element;
    //         break;
    //       case '-':
    //         answer = tempValue - element;
    //         break;
    //     }
    //     tempValue = answer;
    //     index = index + 1;
    //   }
    // }
  }
}
