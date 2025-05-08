import 'package:angelinashop/core/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/colors_app.dart';
import '../../../../core/styles/text_styles.dart';

class CustomDropDownButton extends StatelessWidget {
  final String? selectedOption;
  final List<String> options;
  final String hint;
  final void Function(String) onChanged;
  final double? width;
  final double? height;

  const CustomDropDownButton({
    super.key,
    required this.selectedOption,
    required this.options,
    required this.onChanged,
    required this.hint,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          value: options.contains(selectedOption) ? selectedOption : null,
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: ColorsApp.kPrimaryColor, size: 18.sp),
          iconEnabledColor: ColorsApp.kPrimaryColor,
          dropdownColor: Colors.white,
          style: TextStyles.k10.copyWith(color: ColorsApp.kLightGreyColor),
          hint: Text(hint,
              style: TextStyles.k10.copyWith(color: ColorsApp.kLightGreyColor)),
          onChanged: options.isEmpty
              ? null
              : (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
