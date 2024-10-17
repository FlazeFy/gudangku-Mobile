import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_by_category.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_by_favorite.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_by_room.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  StateStatsPageState createState() => StateStatsPageState();
}

class StateStatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ComponentAppBar(title: 'Stats', isSubMenu: true),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: spaceMD),
          children: const [
            SizedBox(height: spaceMD),
            TotalInventoryByCategory(),
            TotalInventoryByFavorite(),
            TotalInventoryByRoom()
          ],
        ));
  }
}
