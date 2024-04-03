import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/inventory/stats/models/queries.dart';
import 'package:gudangku/modules/api/inventory/stats/services/queries.dart';
import 'package:gudangku/modules/component/charts/pie_chart.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';

class TotalInventoryByRoom extends StatefulWidget {
  @override
  State<TotalInventoryByRoom> createState() => _TotalInventoryByRoomState();
}

class _TotalInventoryByRoomState extends State<TotalInventoryByRoom> {
  List<PieData> chartData = [];
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
        future: apiService?.getTotalInventoryByRoom(),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueriesPieChartModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<QueriesPieChartModel> contents = snapshot.data ?? [];
            chartData.clear();

            for (var content in contents) {
              String label = content.ctx;
              int total = content.total;
              PieData pieData = PieData(label, total);
              chartData.add(pieData);
            }

            return _buildListView(chartData);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(List<PieData> contents) {
    return Container(
        margin: const EdgeInsets.all(spaceSM),
        child: getPieChart(chartData, 'Total Inventory By Room'));
  }
}
