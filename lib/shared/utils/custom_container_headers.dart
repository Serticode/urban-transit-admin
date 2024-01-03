import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class CustomContainerHeaders extends StatelessWidget {
  final String title;
  final void Function() minimize;
  final void Function() maximize;
  final void Function() close;
  const CustomContainerHeaders(
      {super.key,
      required this.title,
      required this.minimize,
      required this.maximize,
      required this.close});

  //! DEFINITIONS
  static const List<IconData> menuIcons = [
    Icons.remove,
    Icons.open_in_full,
    Icons.close
  ];

  static final List<Color> menuIconColours = [
    Colors.grey.shade800,
    AppThemeColours.appGreen,
    AppThemeColours.appRed
  ];

  static const List<Color> menuIconBGColour = [
    AppThemeColours.appGreyBGColour,
    AppThemeColours.appGreenTransparent,
    AppThemeColours.appRedTransparent
  ];

  @override
  Widget build(BuildContext context) {
    return AppFadeAnimation(
        delay: 1.2,
        child: Row(children: [
          //! TITLE
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w600,
                ),
          ),

          //! SPACER
          const Spacer(),

          //! BUTTONS - MINIMIZE
          ...menuIcons.map((icon) => Padding(
              padding: EdgeInsets.only(right: 6.0.sp),
              child: InkWell(
                  onTap: () =>
                      menuIconOnTapTrigger(index: menuIcons.indexOf(icon)),
                  child: CircleAvatar(
                      radius: 14.0.r,
                      backgroundColor:
                          menuIconBGColour.elementAt(menuIcons.indexOf(icon)),
                      child: Icon(icon,
                          size: 12.0.sp,
                          color: menuIconColours
                              .elementAt(menuIcons.indexOf(icon)))))))
        ]));
  }

  void menuIconOnTapTrigger({required int index}) {
    switch (index) {
      case 0:
        minimize();
        break;
      case 1:
        maximize();
        break;
      case 2:
        close();
        break;
      default:
    }
  }
}
