import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class AppElevatedButton extends StatelessWidget {
  final Widget? child;
  final void Function()? onPressed;
  final Color? buttonColour;
  final String? buttonTitle;

  //! CONSTRUCTOR
  const AppElevatedButton({
    super.key,
    this.child,
    this.onPressed,
    this.buttonColour,
    this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 60.0.h,
      width: 394.0.w,
      child: ElevatedButton(
        //! ON PRESSED
        onPressed: () => onPressed!(),

        //! BUTTON STYLE
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColour ?? AppThemeColours.appBlue),

        //! BUTTON CHILD
        child: Text(
          buttonTitle ?? "No button title",
          style: textTheme.bodyMedium!
              .copyWith(color: AppThemeColours.elevatedButtonTextColour),
        ),
      ),
    );
  }
}
