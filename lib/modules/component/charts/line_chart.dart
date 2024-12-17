import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/stats/models/queries.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget getSplineChart(List<TwoLineData> chartData, String? title, String? extra,
    String lineOne, String lineTwo) {
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
        )),
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
    axes: <ChartAxis>[
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
        name: lineOne,
        dataLabelMapper: (TwoLineData data, _) => data.yData != 0
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
      BarSeries<TwoLineData, String>(
        dataSource: chartData,
        xValueMapper: (TwoLineData data, _) => data.xData,
        yValueMapper: (TwoLineData data, _) => data.zData,
        name: lineTwo,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(roundedSM),
          topRight: Radius.circular(roundedSM),
        ),
        dataLabelMapper: (TwoLineData data, _) => data.zData != 0
            ? '${extra ?? ''}${double.parse(data.zData.toStringAsFixed(2))}'
            : null,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
              fontSize: textSM, fontWeight: FontWeight.w500, color: whiteColor),
        ),
      ),
    ],
  );
}
