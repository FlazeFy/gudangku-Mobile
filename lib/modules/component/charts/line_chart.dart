import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/global.dart';
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
        : const ChartTitle(),
    legend: const Legend(
        isVisible: true,
        textStyle: TextStyle(
          color: whiteColor,
        )),
    primaryXAxis: const CategoryAxis(
      title: AxisTitle(
        text: '',
      ),
      labelStyle: TextStyle(
        color: whiteColor,
      ),
    ),
    primaryYAxis: const NumericAxis(
      title: AxisTitle(
        text: '',
      ),
      labelStyle: TextStyle(
        color: whiteColor,
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
