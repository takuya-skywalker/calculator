const marks = ['+', '-', '×', '÷','±','%'];

class Calculator{
  static List number = [];
  static List mark = [];
  static String buffer = '';

  static void button(String letter){
    if(marks.contains(letter)){
      mark.add(letter);
      number.add(double.parse(buffer));
      buffer = '';
    }
    else if(letter == 'C'){
      number.clear();
      mark.clear();
      buffer = '';
    }
    else if(letter == '='){
      return;
    }
    else{
      buffer += letter;
    }
  }

  static double result = 0;
  static String execute(){
    number.add(double.parse(buffer));
    if (number.isEmpty)
      {return '0';
      }
    result = number[0];
    for (int i = 0; i < mark.length; i++) {
      if (mark[i] == '+') {
        result += number[i + 1];
      }else if (mark[i] == '-') {
        result -= number[i + 1];
      }else if (mark[i] == '×') {
        result *= number[i + 1];
      }else if (mark[i] == '÷' && number[i + 1] != 0) {
        result /= number[i + 1];
      }else {
        return 'e';
      }}
    number.clear();
    mark.clear();
    buffer = '';
    var resultStr = result.toString().split('.');
    return resultStr[1] == '0' ? resultStr[0] : result.toString();
  }
}