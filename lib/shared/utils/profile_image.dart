import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final String imageURL;
  const ProfilePhotoWidget({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return //! LEADING
        CircleAvatar(
      radius: 21.0.r,
      backgroundColor: AppThemeColours.appBlueTransparent,
      child: CircleAvatar(
        radius: 18.0.r,
        backgroundColor: AppThemeColours.appWhiteBGColour,
        child: Image.asset(
          imageURL,
          fit: BoxFit.contain,
          scale: 2.0.sp,
        ),
      ),
    );
  }
}
