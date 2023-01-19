import 'package:flutter/material.dart';

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
        onPressed: widget.onPressed,
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
