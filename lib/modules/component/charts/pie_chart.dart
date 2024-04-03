import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget getPieChart(List<PieData> chartData, String title) {
  return SfCircularChart(
      title: ChartTitle(
          text: title, textStyle: const TextStyle(color: primaryColor)),
      legend: const Legend(
          isVisible: true,
          padding: spaceLG,
          backgroundColor: darkColor,
          position: LegendPosition.right,
          orientation: LegendItemOrientation.vertical,
          textStyle: TextStyle(color: whiteColor),
          borderColor: primaryColor),
      series: <CircularSeries>[
        PieSeries<PieData, String>(
            explode: true,
            explodeIndex: 0,
            dataSource: chartData,
            xValueMapper: (PieData data, _) => data.xData,
            yValueMapper: (PieData data, _) => data.yData,
            dataLabelMapper: (PieData data, _) => data.text,
            dataLabelSettings: const DataLabelSettings(isVisible: true)),
      ]);
}
