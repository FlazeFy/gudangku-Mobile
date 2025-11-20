import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/report/model/queries.dart';
import 'package:gudangku/modules/api/report/service/queries.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';

class GetReportByInventoryId extends StatefulWidget {
  const GetReportByInventoryId(
      {super.key, required this.inventoryName, required this.inventoryId});
  final String inventoryName;
  final String inventoryId;

  @override
  StateGetReportByInventoryId createState() => StateGetReportByInventoryId();
}

class StateGetReportByInventoryId extends State<GetReportByInventoryId> {
  late ReportQueriesService apiReportQuery;
  List<ReportModel>? dt = [];
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    apiReportQuery = ReportQueriesService();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    var data = await apiReportQuery.getReportByInventoryId(
        widget.inventoryName, widget.inventoryId, page);
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

  Widget _buildListView(List<ReportModel>? data) {
    if (data != null && data.length > 0) {
      return Column(
        children: data.map((dt) {
          return Container(
            padding: const EdgeInsets.all(spaceMD),
            decoration: BoxDecoration(
                border: Border.all(width: spaceMini / 2, color: primaryColor),
                borderRadius:
                    const BorderRadius.all(Radius.circular(roundedLG))),
            margin: const EdgeInsets.only(bottom: spaceMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ComponentText(
                        type: 'content_sub_title', text: dt.reportTitle),
                    const Spacer(),
                    ComponentButton(
                        type: 'button_tag', text: dt.reportCategory),
                  ],
                ),
                const SizedBox(height: spaceMD),
                ComponentText(
                    type: dt.reportDesc != null ? 'content_body' : 'no_data',
                    text: dt.reportDesc ?? 'report description'),
                const SizedBox(height: spaceMD),
                const ComponentText(type: 'content_sub_title', text: 'Items :'),
                ComponentText(
                  type: dt.reportItems != null ? 'content_body' : 'no_data',
                  text: dt.reportItems ?? 'report items',
                ),
                const SizedBox(height: spaceSM),
                ComponentText(
                  type: 'content_body',
                  text: "Created At : ${dt.createdAt}",
                  fstyle: FontStyle.italic,
                  color: greyColor,
                ),
              ],
            ),
          );
        }).toList(),
      );
    } else if (data != null && data.isEmpty) {
      return const Text("This item doesn't asigned in any report");
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
