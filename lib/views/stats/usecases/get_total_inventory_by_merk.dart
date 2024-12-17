import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/stats/models/queries.dart';
import 'package:gudangku/modules/api/stats/services/queries.dart';
import 'package:gudangku/modules/component/charts/pie_chart.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';

class TotalInventoryByMerk extends StatefulWidget {
  const TotalInventoryByMerk({super.key});

  @override
  State<TotalInventoryByMerk> createState() => _TotalInventoryByMerkState();
}

class _TotalInventoryByMerkState extends State<TotalInventoryByMerk> {
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
        future: apiService?.getTotalInventoryByMerk(statsType),
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
        child: getPieChart(chartData, 'Total Inventory By Merk'));
  }
}
