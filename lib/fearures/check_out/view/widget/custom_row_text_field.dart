import 'package:flutter/material.dart';

class CustomRowTextField extends StatelessWidget {
  const CustomRowTextField({super.key, this.child1, this.child2});

  final Widget? child1;
  final Widget? child2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: child1 ?? const SizedBox(),
        ),
        SizedBox(width: 20),
        Expanded(
          child: child2 ?? const SizedBox(),
        ),
      ],
    );
  }
}
