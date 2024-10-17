import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/stats/models/queries.dart';
import 'package:gudangku/modules/api/stats/services/queries.dart';
import 'package:gudangku/modules/component/charts/line_chart.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';

class TotalReportSpendingPerMonth extends StatefulWidget {
  const TotalReportSpendingPerMonth({super.key});

  @override
  State<TotalReportSpendingPerMonth> createState() =>
      _TotalReportSpendingPerMonthState();
}

class _TotalReportSpendingPerMonthState
    extends State<TotalReportSpendingPerMonth> {
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
        future: apiService?.getTotalReportSpendingPerMonth('2024'),
        builder: (BuildContext context,
            AsyncSnapshot<List<StatsTotalReportSpendingModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<StatsTotalReportSpendingModel> contents = snapshot.data ?? [];
            chartData.clear();

            for (var content in contents) {
              String label = content.ctx;
              dynamic averagePrice = content.avgPrice;
              dynamic totalPrice = content.totalPrice;
              TwoLineData lineData =
                  TwoLineData(label, totalPrice, averagePrice);
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
        child: getSplineChart(chartData, 'Total Report Spending Per Month',
            'Rp. ', 'Total Price', 'Average Price'));
  }
}
