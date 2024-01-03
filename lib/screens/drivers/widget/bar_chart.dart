import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class AppBarChart extends StatelessWidget {
  const AppBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 230.0.h, width: double.infinity, child: const TheBarChart());
  }
}

class TheBarChart extends StatefulWidget {
  const TheBarChart({super.key});

  List<Color> get availableColors => const <Color>[
        AppThemeColours.appBlueTransparent,
        AppThemeColours.appBlue
      ];

  @override
  State<TheBarChart> createState() => _TheBarChartState();
}

class _TheBarChartState extends State<TheBarChart> {
  final Color barBackgroundColor =
      AppThemeColours.appBlueTransparent.withOpacity(0.5);
  final Duration animDuration = const Duration(milliseconds: 350);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) =>
      BarChart(isPlaying ? randomData() : mainBarData(),
          swapAnimationDuration: animDuration);

  //! REFRESH GRAPH STATE
  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
        x: x,
        barsSpace: 0.5.sp,
        barRods: [
          BarChartRodData(
              toY: isTouched ? y + 3 : y,
              color: isTouched ? AppThemeColours.appBlue : barColor,
              width: width,
              borderRadius: BorderRadius.circular(5.0.r),
              borderSide: isTouched
                  ? BorderSide(width: 3.sp, color: AppThemeColours.appGreen)
                  : const BorderSide(color: Colors.white, width: 0),
              backDrawRodData: BackgroundBarChartRodData(
                  show: true, toY: 20, color: barBackgroundColor))
        ],
        showingTooltipIndicators: showTooltips);
  }

  List<BarChartGroupData> showingGroups() => List.generate(5, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5,
                isTouched: i == touchedIndex,
                width: 65.0.sp,
                barColor: AppThemeColours.appBlueTransparent);
          case 1:
            return makeGroupData(1, 8,
                isTouched: i == touchedIndex,
                width: 65.0.sp,
                barColor: AppThemeColours.appBlueTransparent);
          case 2:
            return makeGroupData(2, 6,
                isTouched: i == touchedIndex,
                width: 65.0.sp,
                barColor: AppThemeColours.appBlueTransparent);
          case 3:
            return makeGroupData(3, 16,
                isTouched: i == touchedIndex,
                width: 65.0.sp,
                barColor: AppThemeColours.appBlueTransparent);
          case 4:
            return makeGroupData(4, 12,
                isTouched: i == touchedIndex,
                width: 65.0.sp,
                barColor: AppThemeColours.appBlueTransparent);

          default:
            return throw Error();
        }
      });

  BarChartData randomData() {
    return BarChartData(
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getTitles,
                    reservedSize: 38)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(5, (i) {
          switch (i) {
            case 0:
              return makeGroupData(0, Random().nextInt(15).toDouble() + 6,
                  barColor: widget.availableColors[
                      Random().nextInt(widget.availableColors.length)],
                  width: 65.0.sp);
            case 1:
              return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
                  barColor: widget.availableColors[
                      Random().nextInt(widget.availableColors.length)],
                  width: 65.0.sp);
            case 2:
              return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
                  barColor: widget.availableColors[
                      Random().nextInt(widget.availableColors.length)],
                  width: 65.0.sp);
            case 3:
              return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
                  barColor: widget.availableColors[
                      Random().nextInt(widget.availableColors.length)],
                  width: 65.0.sp);
            case 4:
              return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
                  barColor: widget.availableColors[
                      Random().nextInt(widget.availableColors.length)],
                  width: 65.0.sp);

            default:
              return throw Error();
          }
        }),
        gridData: FlGridData(show: false));
  }

  BarChartData mainBarData() {
    return BarChartData(
        barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: AppThemeColours.appWhiteBGColour,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  String weekDay;
                  switch (group.x) {
                    case 0:
                      weekDay = 'Monday';
                      break;
                    case 1:
                      weekDay = 'Tuesday';
                      break;
                    case 2:
                      weekDay = 'Wednesday';
                      break;
                    case 3:
                      weekDay = 'Thursday';
                      break;
                    case 4:
                      weekDay = 'Friday';
                      break;
                    case 5:
                      weekDay = 'Saturday';
                      break;
                    case 6:
                      weekDay = 'Sunday';
                      break;
                    default:
                      throw Error();
                  }
                  return BarTooltipItem(
                      '$weekDay\n',
                      Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 16.0.sp),
                      children: <TextSpan>[
                        TextSpan(
                            text: (rod.toY - 1).toString(),
                            style: TextStyle(
                                color: AppThemeColours.appBlue,
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600))
                      ]);
                }),

            //! CALL BACK ON TOUCH
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              });
            }),
        titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: getTitles,
                    reservedSize: 38)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        borderData: FlBorderData(show: false),
        barGroups: showingGroups(),
        gridData: FlGridData(show: true));
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, space: 16, child: text);
  }
}
