import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/stats/models/queries.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget getSingleLineChart(
    List<OneLineData> chartData, String? title, String? extra, String lineOne) {
  return SfCartesianChart(
    title: title != null
        ? ChartTitle(
            text: title,
            textStyle: const TextStyle(color: whiteColor, fontSize: 18),
          )
        : ChartTitle(),
    legend: Legend(
      isVisible: true,
      textStyle: const TextStyle(
        color: whiteColor,
      ),
    ),
    primaryXAxis: CategoryAxis(
      title: AxisTitle(
        text: '',
      ),
      labelStyle: const TextStyle(
        color: whiteColor,
      ),
    ),
    primaryYAxis: NumericAxis(
      title: AxisTitle(
        text: '',
      ),
      labelStyle: const TextStyle(
        color: whiteColor,
      ),
    ),
    series: <CartesianSeries>[
      SplineSeries<OneLineData, String>(
        dataSource: chartData,
        xValueMapper: (OneLineData data, _) => data.xData,
        yValueMapper: (OneLineData data, _) => data.yData,
        name: lineOne,
        dataLabelMapper: (OneLineData data, _) => data.yData != 0
            ? '${extra ?? ''}${double.parse(data.yData.toStringAsFixed(2))}'
            : null,
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
    ],
  );
}
