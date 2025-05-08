import 'package:angelinashop/core/widgets/custom_rating_row.dart';
import 'package:flutter/material.dart';
import '../styles/colors_app.dart';
import '../styles/text_styles.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText(
      {super.key, this.title, this.child, this.maxLines, this.titleStyle});

  final String? title;
  final Widget? child;
  final int? maxLines;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines ?? 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: "${title ?? ""} ",
            style: titleStyle ??
                TextStyles.k12.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.kBlackColor,
                ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: child ?? CustomRatingRow(),
          ),
        ],
      ),
    );
  }
}
