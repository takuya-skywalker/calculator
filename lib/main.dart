import 'package:calculator2/buttons/mark_button.dart';
import 'package:calculator2/buttons/num_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {

  //実際に表示される値
  String textNum = '0';
  String value = '0';
  //valueを保管しておく
  List<String> nums = ['0'];
  //入力したmarkを保管しておく
  List<String> marks = [];
  //numsの番地
  int index = 0;
  //計算結果を一時的に保管
  double resultNum = 0;

  List<String> stackNums = [];

  List<String> stackMarks = [];

  double stackResult = 0;

  double? res;

  //3桁ごとにカンマ
  final formatter = NumberFormat("#,###");

  //数字を押したときの処理
  void addNumText(String num) {
    setState(() {
      //符号の後に数字を入力するとき1度valueを0にする
      if(nums.length == marks.length && marks.contains('%') == false){
        value = '0';
        value = num;
        textNum = num;
        nums.add(num);
      //％の後にすぐ数字を入力した場合
      }else if(nums.length == marks.length && marks.contains('%')){
        nums[index] = num;
        marks.removeLast();
        value = num;
        textNum = num;
      //数字入力の基本
      }else{
        int length = value.length;
        if(value.contains('-')){
          length = length - 1;
        }
        if(value.contains('.')) {
          length = length - 1;
        }
        if(value == '0' && textNum == '0') {
          value = num;
          textNum = num;
          nums.first = num;
        }else if(value == '-0'){
          value = value.replaceFirst('0', num);
          nums[index] = value;
          textNum = value;
        }else if(length >= 9) {
        }else if(textNum.endsWith('.')) {
          value = '$value.$num';
          nums[index] = value;
          textNum += num;
        }else{
          if (value.contains('.')) {
            value += num;
            textNum += num;
            nums[index] = value;
          }else{
            value += num;
            textNum += num;
            nums[index] = value;
            textNum = formatter.format(double.parse(value));
          }
        }
      }
    });
  }

  void behindCalculation(){
    stackMarks = marks;
    stackNums = nums;
    for(int i = stackNums.length; i > 0; i--){
      if(stackMarks.contains('÷')){
        int divIndex = stackMarks.indexOf('÷');
        stackResult = double.parse(stackNums[divIndex]) / double.parse(stackNums[divIndex + 1]);
        stackNums[divIndex] = stackResult.toString();
        stackNums.removeAt(divIndex + 1);
        stackMarks.removeAt(divIndex);
      }else if(stackMarks.contains('×')){
        int multiIndex = stackMarks.indexOf('×');
        stackResult = double.parse(stackNums[multiIndex]) * double.parse(stackNums[multiIndex + 1]);
        stackNums[multiIndex] = stackResult.toString();
        stackNums.removeAt(multiIndex + 1);
        stackMarks.removeAt(multiIndex);
      }else{
        if(stackMarks.length > 1){
          if(stackMarks.first == '＋'){
            stackResult = double.parse(stackNums[0]) + double.parse(stackNums[1]);
            stackNums[0] = stackResult.toString();
            stackNums.removeAt(1);
            stackMarks.removeAt(0);
          }else{
            stackResult = double.parse(stackNums[0]) - double.parse(stackNums[1]);
            stackNums[0] = stackResult.toString();
            stackNums.removeAt(1);
            stackMarks.removeAt(0);
          }
        }else{
          if(stackMarks.first == '＋'){
            stackResult = double.parse(stackNums[0]) + double.parse(stackNums[1]);
          }else{
            stackResult = double.parse(stackNums[0]) - double.parse(stackNums[1]);
          }
        }
      }
    }
    value = stackResult.toString();
    textNum = value;
  }

  //+-×÷=が押された時の計算処理など
  void calculateFormula(){
    for(int i = 0; nums.length > i; i++){
      if(i == 0){
        resultNum = double.parse(nums.first);
      }else if(marks.length > i - 1){
        switch(marks[i - 1]){
          case '＋':
            resultNum += double.parse(nums[i]);
            value = resultNum.toString();
            textNum = formatter.format(double.parse(value));
            if(value.endsWith('.0')){
              value = value.substring(0,value.length - 2);
              textNum = formatter.format(double.parse(value));
            }
            break;
          case '－':
            resultNum -= double.parse(nums[i]);
            value = resultNum.toString();
            textNum = formatter.format(double.parse(value));
            if(value.endsWith('.0')){
              value = value.substring(0,value.length - 2);
              textNum = formatter.format(double.parse(value));
            }
            break;
          case '×':
            resultNum *= double.parse(nums[i]);
            value = resultNum.toString();
            textNum = formatter.format(double.parse(value));
            if(value.endsWith('.0')){
              value = value.substring(0,value.length - 2);
              textNum = formatter.format(double.parse(value));
            }
            break;
          case '÷':
            resultNum /= double.parse(nums[i]);
            value = resultNum.toString();
            textNum = formatter.format(double.parse(value));
            if(value.endsWith('.0')){
              value = value.substring(0,value.length - 2);
              textNum = formatter.format(double.parse(value));
            }
            break;
        }
      }
    }
  }

  void changeSign (){
    if(value.contains('-')){
      value = value.substring(1,value.length);
      textNum = textNum.substring(1,textNum.length);
      nums[index] = nums[index].substring(1,nums[index].length);
    }else{
      value = '-$value';
      textNum = '-$textNum';
      nums[index] = value;
    }
  }

  void percent(){
    setState(() {
      if(index == 0){
        resultNum = double.parse(nums[0]) / 100;
        value = resultNum.toString();
        nums[0] = value;
        textNum = value;
        marks.add('%');
      }else{
        nums[index] = (resultNum * double.parse(nums[index]) / 100).toString();
        resultNum = double.parse(nums[index]);
        value = nums[index];
        marks.add('%');
      }
      if(value.endsWith('.0')){
        value = value.substring(0,value.length - 2);
      }
    });
  }

  //小数点を入力する関数
  void dotText() {
    setState(() {
      if(textNum.contains('.')){
        textNum = textNum;
      }else if(value.length >= 10 && value.contains('-')) {
      }else if(value.length >= 9 && !value.contains('-')) {
      }else{
        textNum = '$textNum.';
      }
    });
  }

  //Cを押してvalueを0にする関数
  void clearNumText() {
    setState(() {
      value = '0';
      nums = ['0'];
      marks = [];
      resultNum = 0;
      index = 0;
      textNum = '0';
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
      buttonMark: '＋',
      backGroundColor: Colors.orange,
      onPressed: (){
        setState(() {
          if(marks.contains('%')){
            marks.removeLast();
          }
          if(marks.contains('=')){
            marks.removeLast();
          }

          if(nums.length > marks.length) {
            marks.add('＋');
            calculateFormula();
          }else{
            marks.removeLast();
            marks.add('＋');
          }
          index++;
        });
      },
    );

    MarkButton minusButton = MarkButton(
      buttonMark: '－',
      backGroundColor: Colors.orange,
      onPressed: (){
        setState(() {
          if(marks.contains('%')){
            marks.removeLast();
          }
          if(marks.contains('=')){
            marks.removeLast();
          }
          if(nums.length > marks.length) {
            marks.add('－');
            calculateFormula();
          }else {
            marks.removeLast();
            marks.add('－');
          }
          index++;
        });
      },
    );

    MarkButton multiButton = MarkButton(
      buttonMark: '×',
      backGroundColor: Colors.orange,
      onPressed: (){
        setState(() {
          if(marks.contains('%')){
            marks.removeLast();
          }
          if(marks.contains('=')){
            marks.removeLast();
          }
          if(nums.length > marks.length) {
            marks.add('×');
            calculateFormula();
          }else {
            marks.removeLast();
            marks.add('×');
          }
          index++;
        });
      },
    );

    MarkButton divButton = MarkButton(
      buttonMark: '÷',
      backGroundColor: Colors.orange,
      onPressed: (){
        setState(() {
          if(marks.contains('%')){
            marks.removeLast();
          }
          if(marks.contains('=')){
            marks.removeLast();
          }
          if(nums.length > marks.length) {
            marks.add('÷');
            calculateFormula();
          }else {
            marks.removeLast();
            marks.add('÷');
          }
          index++;
        });
      },
    );

    MarkButton equalButton = MarkButton(
      buttonMark: '=',
      backGroundColor: Colors.orange,
      onPressed: (){
        setState(() {
          behindCalculation();
          marks.clear();
          nums.clear();
          index = 0;
          stackResult = 0;
          stackMarks.clear();
          stackNums.clear();
          marks.add('=');
          nums.add(resultNum.toString());
          if(textNum.endsWith('.0')){
            textNum = textNum.substring(0,textNum.length - 2);
          }
          textNum = formatter.format(double.parse(value));

          print(textNum);
          print(value);
          print(nums);
          print(marks);
          print(index);
        });
      },
    );

    MarkButton plusMinusButton = MarkButton(
        buttonMark: '±',
        backGroundColor: Colors.white38,
        onPressed: (){
          setState(() {
            changeSign();
          });
        }
    );

    MarkButton percentButton = MarkButton(
        buttonMark: '%',
        backGroundColor: Colors.white38,
        onPressed: (){
          percent();
        },
    );


    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.only(left:15, top:120, right:15, bottom:5),
            height: 110,
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.fitWidth ,
              child: Text(
                textNum,
                style: const TextStyle(fontSize: 100, color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MarkButton(
                  buttonMark: 'C',
                  backGroundColor: Colors.white38,
                  onPressed: () => clearNumText()),
              plusMinusButton,
              percentButton,
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





