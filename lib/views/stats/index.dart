import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/navbar.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_by_category.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_by_favorite.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_by_merk.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_by_room.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_created_per_month.dart';
import 'package:gudangku/views/stats/usecases/get_total_report_created_per_month.dart';
import 'package:gudangku/views/stats/usecases/get_total_report_spending_per_month.dart';
import 'package:gudangku/views/stats/usecases/get_total_report_used_per_month.dart';
import 'package:gudangku/views/stats/usecases/toggle_total.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  StateStatsPageState createState() => StateStatsPageState();
}

class StateStatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    globalStatsTabController = TabController(
        length: 2, vsync: this, initialIndex: selectedStatsTabIndex);
    globalStatsTabController?.addListener(() {
      if (!globalStatsTabController!.indexIsChanging) {
        selectedStatsTabIndex = globalStatsTabController!.index;
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    globalStatsTabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          Get.to(const BottomBar());
          return true;
        },
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: TabBar(
                labelColor: primaryColor,
                indicatorColor: primaryColor,
                controller: globalStatsTabController,
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
                controller: globalStatsTabController,
                children: <Widget>[
                  Center(
                    child: ListView(
                      children: const [
                        TotalInventoryByCategory(),
                        TotalInventoryByRoom(),
                        TotalInventoryByFavorite(),
                        TotalInventoryByMerk(),
                      ],
                    ),
                  ),
                  Center(
                    child: ListView(
                      children: const [
                        TotalInventoryCreatedPerMonth(),
                        TotalReportCreatedPerMonth(),
                        TotalReportSpendingPerMonth(),
                        TotalReportUsedPerMonth()
                      ],
                    ),
                  )
                ],
              ),
              floatingActionButton: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      heroTag: 'print',
                      onPressed: () {},
                      backgroundColor: primaryColor,
                      child: const FaIcon(
                        FontAwesomeIcons.download,
                        color: whiteColor,
                      ),
                    ),
                    const SizedBox(height: spaceMD),
                    FloatingActionButton(
                      heroTag: 'info',
                      onPressed: () {
                        Get.dialog(AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          title: null,
                          backgroundColor: darkColor,
                          content: SizedBox(
                            width: Get.height,
                            height: 150,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: spaceMD,
                                        right: spaceMD,
                                        top: spaceMD),
                                    child: Row(children: [
                                      const ComponentText(
                                          type: 'content_title',
                                          text: 'Information'),
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  whiteColor),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: dangerBG, width: 1.5)),
                                        ),
                                        onPressed: () => Get.back(),
                                      ),
                                    ]),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(spaceMD),
                                    child: ComponentText(
                                        type: 'content_sub_title',
                                        text:
                                            'Stats will refresh every ${(statsFetchRestTime / 60).ceil()} minutes after last time you access this page'),
                                  )
                                ]),
                          ),
                        ));
                      },
                      backgroundColor: primaryColor,
                      child: const FaIcon(
                        FontAwesomeIcons.circleInfo,
                        color: whiteColor,
                      ),
                    ),
                    const SizedBox(height: spaceMD),
                    const ToggleTotal(),
                    const SizedBox(height: spaceMD),
                    FloatingActionButton(
                      heroTag: 'back',
                      onPressed: () {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                        ]);
                        Get.to(const BottomBar());
                      },
                      backgroundColor: dangerBG,
                      child: const FaIcon(
                        FontAwesomeIcons.xmark,
                        color: whiteColor,
                      ),
                    ),
                  ]),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
            )));
  }
}
