import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/model/queries.dart';
import 'package:gudangku/modules/api/inventory/service/queries.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/converter.dart';
import 'package:gudangku/modules/helpers/generator.dart';
import 'package:gudangku/views/detail_inventory/index.dart';

class GetCalendar extends StatefulWidget {
  const GetCalendar({super.key});

  @override
  StateGetCalendar createState() => StateGetCalendar();
}

class StateGetCalendar extends State<GetCalendar> {
  late InventoryQueriesService apiHistoryQuery;
  List<InventoryCalendarModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    apiHistoryQuery = InventoryQueriesService();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    var data = await apiHistoryQuery.getInventoryCalendar();
    setState(() {
      dt = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : _buildListView(dt),
    );
  }

  Widget _buildListView(List<InventoryCalendarModel> data) {
    if (data.isNotEmpty) {
      final Map<String, List<InventoryCalendarModel>> groupedData = {};
      for (var dt in data) {
        final dateKey = dt.createdAt.split(' ')[0];
        if (!groupedData.containsKey(dateKey)) {
          groupedData[dateKey] = [];
        }
        groupedData[dateKey]!.add(dt);
      }

      final sortedKeys = groupedData.keys.toList()
        ..sort((a, b) => DateTime.parse(a).compareTo(DateTime.parse(b)));
      int i = 0;

      return Column(
        children: sortedKeys.map((date) {
          final items = groupedData[date]!;
          String day = date.substring(8, 10);
          String year = date.substring(0, 4);
          String month = generateMonthName(int.parse(date.substring(5, 7)));

          i++;
          return Container(
              margin: const EdgeInsets.only(bottom: spaceMD),
              decoration: BoxDecoration(
                  border: Border.all(color: whiteColor, width: 1),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(roundedMD))),
              child: ExpansionTile(
                initiallyExpanded: i == 1 ? true : false,
                iconColor: primaryColor,
                title: ComponentText(
                  text: "Created on $day $month $year",
                  type: 'content_sub_title',
                ),
                children: items.map((dt) {
                  return InkWell(
                    onTap: () {
                      Get.to(EditInventoryPage(id: dt.id));
                    },
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(spaceSM),
                      margin: const EdgeInsets.all(spaceXXSM),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: spaceMini / 2, color: primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(roundedLG)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ComponentText(
                            type: 'content_sub_title',
                            text: dt.inventoryName,
                          ),
                          const SizedBox(height: spaceSM),
                          Container(
                            margin: const EdgeInsets.only(right: spaceMD),
                            child: Row(
                              children: [
                                ComponentButton(
                                  type: 'button_tag',
                                  text:
                                      "Rp. ${numberFormat(dt.inventoryPrice)}",
                                ),
                                const Spacer(),
                                ComponentText(
                                  type: 'content_body',
                                  color: greyColor,
                                  fstyle: FontStyle.italic,
                                  text: "Created At : ${dt.createdAt}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ));
        }).toList(),
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
