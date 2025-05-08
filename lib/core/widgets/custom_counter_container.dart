import 'package:angelinashop/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import '../styles/colors_app.dart';
import 'custom_container.dart';

class CustomCounterContainer extends StatelessWidget {
  const CustomCounterContainer({
    super.key,
    this.side,
    this.width,
    this.height,
    required this.text,
    required this.onPressedPlus,
    required this.onPressedMinus,
    this.style,
    this.iconSize,
  });

  final BorderSide? side;
  final double? width, height;
  final String text;
  final TextStyle? style;
  final double? iconSize;

  final void Function() onPressedPlus, onPressedMinus;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: onPressedPlus,
            child: Icon(
              Icons.add,
              color: ColorsApp.kPrimaryColor,
              size: iconSize,
            ),
          ),
          Text(
            text,
            style: style ?? TextStyles.k16,
          ),
          InkWell(
            onTap: onPressedMinus,
            child: Icon(
              Icons.remove,
              color: ColorsApp.kPrimaryColor,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
