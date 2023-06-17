import 'package:flutter/material.dart';

class NeumorphismBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;

  const NeumorphismBox(
      {super.key, this.height, this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness==Brightness.light? Colors.grey.shade500 : Colors.black,
            offset: const Offset(5, 5),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Theme.of(context).brightness==Brightness.light? Colors.white : Colors.grey.shade800,
            offset: const Offset(-5, -5),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}
