import 'package:flutter/material.dart';

enum CalcuratorButtonTheme {
  number,
  operator,
  other,
}

class CalcuratorButton extends StatefulWidget {
  const CalcuratorButton({
    Key? key,
    required this.theme,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final CalcuratorButtonTheme theme;
  final String title;
  final VoidCallback onPressed;

  @override
  State<CalcuratorButton> createState() => _CalcuratorButtonState();
}

class _CalcuratorButtonState extends State<CalcuratorButton> {
  @override
  Widget build(BuildContext context) {
    late final Color color;

    switch (widget.theme) {
      case (CalcuratorButtonTheme.number):
        color = Colors.white12;
        break;
      case (CalcuratorButtonTheme.operator):
        color = Colors.orange;
        break;
      case (CalcuratorButtonTheme.other):
        color = Colors.white38;
        break;
    }

    return SizedBox(
      width: widget.title == '0' ? 180 : 80,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: widget.title == '0'
              ? const StadiumBorder()
              : const CircleBorder(),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 38,
          ),
        ),
      ),
    );
  }
}
