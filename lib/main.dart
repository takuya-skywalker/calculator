import 'package:calculator2/buttons/mark_button.dart';
import 'package:calculator2/buttons/num_button.dart';
import 'package:flutter/material.dart';


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
  String value = '0';
  //valueを保管しておく
  List<String> nums = ['0'];
  //入力したmarkを保管しておく
  List<String> marks = [];
  //numsの番地
  int index = 0;
  //計算結果を一時的に保管
  double resultNum = 0;


  //数字を押したときの処理
  void addNumText(String num) {
    setState(() {
      //符号の後に数字を入力するとき1度valueを0にする
      if(nums.length == marks.length && marks.contains('%') == false){
        value = '0';
        value = num;
        nums.add(num);
      //％の後にすぐ数字を入力した場合
      } else if(nums.length == marks.length && marks.contains('%')){
        nums[index] = num;
        marks.removeLast();
        value = num;
      //数字入力の基本
      }else {
        if (value == '0') {
          value = num;
          nums.first = num;
        } else {
          value += num;
          nums[index] = value;
        }
      }

    });
  }
  //+-×÷=が押された時の計算処理など
  void calculateFormula(){
    for(int i = 0; nums.length > i; i++){
      if(i == 0){resultNum = double.parse(nums.first);}
      else if(marks.length > i - 1){
        switch(marks[i - 1]){
          case '＋':
            resultNum += double.parse(nums[i]);
            value = resultNum.toString();
            if(value.endsWith('.0')){
              value = value.substring(0,value.length - 2);
            }
            break;
          case '－':
            resultNum -= double.parse(nums[i]);
            value = resultNum.toString();
            if(value.endsWith('.0')){
              value = value.substring(0,value.length - 2);
            }
            break;
          case '×':
            resultNum *= double.parse(nums[i]);
            value = resultNum.toString();
            if(value.endsWith('.0')){
              value = value.substring(0,value.length - 2);
            }
            break;
          case '÷':
            resultNum /= double.parse(nums[i]);
            value = resultNum.toString();
            if(value.endsWith('.0')){
              value = value.substring(0,value.length - 2);
            }
            break;
        }
      }
    }
  }

  void plusOrMinus (){
    if(value.contains('-')){
      value = value.substring(1,value.length);
    } else {
      value = '-$value';
    }
  }

  void percent(){
    setState(() {
      if(index == 0){
        resultNum = double.parse(nums[0]) / 100;
        value = resultNum.toString();
        nums[0] = resultNum.toString();
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
      if(value.contains('.') == true){
        value = value;
      }else{
        value = '$value.';
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
          if(nums.length > marks.length) {
            index++;
            marks.add('＋');
            calculateFormula();
          }
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
          if(nums.length > marks.length) {
            index++;
            marks.add('－');
            calculateFormula();
          }
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
          if(nums.length > marks.length) {
            index++;
            marks.add('×');
            calculateFormula();
          }
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
          if(nums.length > marks.length) {
            index++;
            marks.add('÷');
            calculateFormula();
          }
        });
      },
    );

    MarkButton equalButton = MarkButton(
      buttonMark: '=',
      backGroundColor: Colors.orange,
      onPressed: (){
        setState(() {
          calculateFormula();
          marks.clear();
          nums.clear();
          nums.add(resultNum.toString());
        });
      },
    );

    MarkButton plusMinusButton = MarkButton(
        buttonMark: '±',
        backGroundColor: Colors.white38,
        onPressed: (){
          setState(() {
            plusOrMinus();
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





