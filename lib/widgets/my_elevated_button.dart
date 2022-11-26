import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback onPressed;

  MyElevatedButton(
      {required this.child, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onPressed,
      child: child,
    );
  }
}
