import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/stats/models/queries.dart';
import 'package:gudangku/modules/api/stats/services/queries.dart';
import 'package:gudangku/modules/component/charts/line_chart.dart';
import 'package:gudangku/modules/global/style.dart';

class TotalReportUsedPerMonth extends StatefulWidget {
  const TotalReportUsedPerMonth({super.key});

  @override
  State<TotalReportUsedPerMonth> createState() =>
      _TotalReportUsedPerMonthState();
}

class _TotalReportUsedPerMonthState extends State<TotalReportUsedPerMonth> {
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
        future: apiService?.getTotalReportUsedPerMonth('2024'),
        builder: (BuildContext context,
            AsyncSnapshot<List<StatsTotalReportUsedModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<StatsTotalReportUsedModel> contents = snapshot.data ?? [];
            chartData.clear();

            for (var content in contents) {
              String label = content.ctx;
              int totalCheckout = content.totalCheckout;
              int totalWashlist = content.totalWashlist;
              TwoLineData lineData =
                  TwoLineData(label, totalCheckout, totalWashlist);
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
        padding: const EdgeInsets.all(spaceJumbo),
        child: getSplineChart(chartData, 'Total Report Used Per Month', null,
            'Total Checkout', 'Total Washlist'));
  }
}
