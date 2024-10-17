import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_by_category.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_by_favorite.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_by_room.dart';
import 'package:gudangku/views/stats/usecases/get_total_report_created_per_month.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  StateStatsPageState createState() => StateStatsPageState();
}

class StateStatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            labelColor: primaryColor,
            indicatorColor: primaryColor,
            padding: EdgeInsets.only(top: Get.height * 0.05),
            tabs: const <Widget>[
              Tab(
                icon: FaIcon(
                  FontAwesomeIcons.chartPie,
                  color: primaryColor,
                ),
                text: "Variety",
              ),
              Tab(
                  icon: FaIcon(
                    FontAwesomeIcons.chartLine,
                    color: primaryColor,
                  ),
                  text: "Periodic"),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: ListView(
                  children: const [
                    TotalInventoryByCategory(),
                    TotalInventoryByFavorite(),
                    TotalInventoryByRoom(),
                  ],
                ),
              ),
              Center(
                child: ListView(
                  children: const [TotalReportCreatedPerMonth()],
                ),
              )
            ],
          ),
        ));
  }
}
