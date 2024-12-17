import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/stats/models/queries.dart';
import 'package:gudangku/modules/api/stats/services/queries.dart';
import 'package:gudangku/modules/global/style.dart';

import '../../../modules/component/charts/single_line_chart.dart';

class TotalInventoryCreatedPerMonth extends StatefulWidget {
  const TotalInventoryCreatedPerMonth({super.key});

  @override
  State<TotalInventoryCreatedPerMonth> createState() =>
      _TotalInventoryCreatedPerMonthState();
}

class _TotalInventoryCreatedPerMonthState
    extends State<TotalInventoryCreatedPerMonth> {
  List<OneLineData> chartData = [];
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
        future: apiService?.getTotalInventoryCreatedPerMonth('2024'),
        builder: (BuildContext context,
            AsyncSnapshot<List<StatsTotalInventoryCreatedModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<StatsTotalInventoryCreatedModel> contents =
                snapshot.data ?? [];
            chartData.clear();

            for (var content in contents) {
              String label = content.ctx;
              int total = content.total;
              OneLineData lineData = OneLineData(label, total);
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

  Widget _buildListView(List<OneLineData> contents) {
    return Container(
        padding: const EdgeInsets.all(spaceJumbo),
        child: getSingleLineChart(chartData,
            'Total Inventory Created Per Month', null, 'Total Inventory'));
  }
}
