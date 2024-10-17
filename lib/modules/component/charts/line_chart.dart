import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget getSplineChart(
    List<TwoLineData> chartData, String? title, String? extra) {
  return SfCartesianChart(
    title: title != null
        ? ChartTitle(
            text: title,
            textStyle: const TextStyle(color: whiteColor, fontSize: 18),
          )
        : const ChartTitle(),
    legend: const Legend(isVisible: true),
    primaryXAxis: const CategoryAxis(
      title: AxisTitle(
        text: '',
      ),
    ),
    primaryYAxis: const NumericAxis(
      title: AxisTitle(
        text: '',
      ),
    ),
    axes: const <ChartAxis>[
      NumericAxis(
        name: 'secondaryYAxis',
        opposedPosition: true,
        title: AxisTitle(
          text: '',
        ),
      ),
    ],
    series: <CartesianSeries>[
      SplineSeries<TwoLineData, String>(
        dataSource: chartData,
        xValueMapper: (TwoLineData data, _) => data.xData,
        yValueMapper: (TwoLineData data, _) => data.yData,
        name: 'Spline Data',
        dataLabelMapper: (TwoLineData data, _) =>
            '${double.parse(data.yData.toStringAsFixed(2))}$extra',
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            fontSize: textSM,
            fontWeight: FontWeight.w500,
            color: whiteColor,
          ),
        ),
        markerSettings: const MarkerSettings(
          isVisible: true,
          shape: DataMarkerType.circle,
        ),
      ),
      ColumnSeries<TwoLineData, String>(
        dataSource: chartData,
        xValueMapper: (TwoLineData data, _) => data.xData,
        yValueMapper: (TwoLineData data, _) => data.zData,
        name: 'Bar Data',
        yAxisName: 'secondaryYAxis',
        dataLabelMapper: (TwoLineData data, _) =>
            '${double.parse(data.zData.toStringAsFixed(2))}$extra',
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
              fontSize: textSM, fontWeight: FontWeight.w500, color: whiteColor),
        ),
      ),
    ],
  );
}
