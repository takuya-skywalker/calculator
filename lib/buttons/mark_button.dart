import 'package:flutter/material.dart';

class MarkButton extends StatefulWidget {
  const MarkButton(
      {Key? key,
        required this.buttonMark,
        required this.backGroundColor,
        this.onPressed})
      : super(key: key);
  final String buttonMark;
  final Color backGroundColor;
  final VoidCallback? onPressed;

  @override
  State<MarkButton> createState() => _MarkButtonState();
}

class _MarkButtonState extends State<MarkButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backGroundColor,
          shape: const CircleBorder(),
        ),
        onPressed: widget.onPressed ?? () {},
        child: Text(
          widget.buttonMark,
          style: const TextStyle(
            fontSize: 38,
          ),
        ),
      ),
    );
  }
}

