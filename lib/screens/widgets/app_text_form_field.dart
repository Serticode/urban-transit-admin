import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class AppTextFormField extends ConsumerWidget {
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final String? obscuringCharacter;
  final String? Function(String?)? validator;
  final String? hintText;
  final IconData? suffixIcon;
  final Widget? prefixIcon;
  final Color? suffixIconColour;
  final EdgeInsets? padding;
  final void Function(String)? onChanged;

  //! CONSTRUCTOR
  const AppTextFormField({
    super.key,
    this.keyboardType,
    required this.controller,
    this.obscureText,
    this.validator,
    this.obscuringCharacter,
    this.onChanged,
    this.hintText,
    this.suffixIcon,
    this.suffixIconColour,
    this.prefixIcon,
    this.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        contentPadding: padding ??
            EdgeInsets.symmetric(
              vertical: 4.0.h,
              horizontal: 12.0.w,
            ),

        //! FILL
        filled: true,
        fillColor: controller.text.isNotEmpty
            ? AppThemeColours.appBlueTransparent
            : AppThemeColours.textFormFieldBGColour,

        //! HINT DECORATION
        hintText: hintText,
        hintStyle: textTheme.bodyMedium?.copyWith(
          fontSize: 12.0,
          letterSpacing: 1.1,
          color: AppThemeColours.bodyText2TextColour.withOpacity(0.8),
        ),
        errorStyle: textTheme.bodyMedium?.copyWith(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w500,
          color: AppThemeColours.appRed,
        ),

        suffixIcon: InkWell(
          onTap: () {},
          child: Icon(
            suffixIcon,
            color: suffixIconColour,
          ),
        ),
        prefixIcon: prefixIcon,

        //! BORDERS
        //! WHEN INPUT FIELD IS IN FOCUS
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
              width: 1.0.sp,
              color: AppThemeColours.textFormFieldUnfocusedBorderColour),
        ),

        //! ENABLED FIELD
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
              width: 1.0.sp,
              color: AppThemeColours.textFormFieldUnfocusedBorderColour),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.6.w,
            color: AppThemeColours.appRed,
          ),
          borderRadius: BorderRadius.circular(10.0.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.6.w,
            color: AppThemeColours.appRed,
          ),
          borderRadius: BorderRadius.circular(10.0.r),
        ),
      ),

      //! FIELD CONTENT DECORATION
      style: textTheme.bodyMedium?.copyWith(
          color: controller.text.isNotEmpty ? const Color(0xFF333333) : null,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.1),

      //! FUNCTIONS
      validator: validator,
      onChanged: onChanged,
    );
  }
}
