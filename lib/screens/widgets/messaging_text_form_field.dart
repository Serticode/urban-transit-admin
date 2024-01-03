import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class MessagingTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final String? obscuringCharacter;
  final String? Function(String?)? validator;
  final String? hintText;
  final IconData? suffixIcon;
  final Color? suffixIconColour;
  final void Function(String)? onChanged;

  //! CONSTRUCTOR
  const MessagingTextFormField(
      {super.key,
      this.keyboardType,
      required this.controller,
      this.obscureText,
      this.validator,
      this.obscuringCharacter,
      this.onChanged,
      this.hintText,
      this.suffixIcon,
      this.suffixIconColour});

  @override
  Widget build(BuildContext context) {
    //! TEXT THEME
    final TextTheme textTheme = Theme.of(context).textTheme;

    //! MAIN WIDGET
    return TextFormField(
        //! REGULAR PARAMETERS
        controller: controller,
        scrollPhysics: const BouncingScrollPhysics(),
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        obscuringCharacter: obscuringCharacter ?? "*",
        showCursor: true,
        cursorColor: AppThemeColours.primaryColour,

        //! DECORATION STYLING
        decoration: InputDecoration(
            //! FILL
            filled: true,
            fillColor: controller.text.isNotEmpty
                ? AppThemeColours.appBlueTransparent
                : AppThemeColours.textFormFieldBGColour,

            //! HINT DECORATION
            hintText: hintText,
            hintStyle: textTheme.bodyMedium!.copyWith(fontSize: 12.0.sp),
            suffixIcon: InkWell(
                onTap: () {},
                child:
                    Icon(suffixIcon, size: 16.0.sp, color: suffixIconColour)),

            //! BORDERS
            //! WHEN INPUT FIELD IS IN FOCUS
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0.r),
                borderSide: BorderSide(
                    width: 0.8.sp,
                    color: AppThemeColours.textFormFieldUnfocusedBorderColour)),

            //! ENABLED FIELD
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0.r),
                borderSide: BorderSide(
                    width: 0.8.sp,
                    color:
                        AppThemeColours.textFormFieldUnfocusedBorderColour))),

        //! FIELD CONTENT DECORATION
        style: textTheme.bodyMedium!.copyWith(
            fontSize: 14.0.sp,
            color: controller.text.isNotEmpty ? const Color(0xFF333333) : null,
            fontWeight: FontWeight.w500),

        //! FUNCTIONS
        validator: validator,
        onChanged: (value) => onChanged!(value));
  }
}
