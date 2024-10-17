import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/stats/models/queries.dart';
import 'package:gudangku/modules/api/stats/services/queries.dart';
import 'package:gudangku/modules/component/charts/line_chart.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';

class TotalReportCreatedPerMonth extends StatefulWidget {
  const TotalReportCreatedPerMonth({super.key});

  @override
  State<TotalReportCreatedPerMonth> createState() =>
      _TotalReportCreatedPerMonthState();
}

class _TotalReportCreatedPerMonthState
    extends State<TotalReportCreatedPerMonth> {
  List<TwoLineData> chartData = [];
  QueriesStatsService? apiService;

  @override
  void initState() {
    super.initState();
    apiService = QueriesStatsService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getTotalReportCreatedPerMonth('2024'),
        builder: (BuildContext context,
            AsyncSnapshot<List<StatsTotalReportCreatedModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<StatsTotalReportCreatedModel> contents = snapshot.data ?? [];
            chartData.clear();

            for (var content in contents) {
              String label = content.ctx;
              int totalReport = content.totalReport;
              int totalItem = content.totalItem;
              TwoLineData lineData = TwoLineData(label, totalReport, totalItem);
              chartData.add(lineData);
            }

            return _buildListView(chartData);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(List<TwoLineData> contents) {
    return Container(
        width: Get.height * 2,
        height: Get.width * 1.4,
        padding: const EdgeInsets.all(spaceJumbo),
        child: Transform.rotate(
            angle: 90 * (3.14 / 180),
            child: getSplineChart(
                chartData, 'Total Report Created Per Month', null)));
  }
}
