import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/history/model/queries.dart';
import 'package:gudangku/modules/api/report/model/queries.dart';
import 'package:gudangku/modules/api/report/service/queries.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';

class GetAllReport extends StatefulWidget {
  const GetAllReport({super.key});

  @override
  StateGetAllReport createState() => StateGetAllReport();
}

class StateGetAllReport extends State<GetAllReport> {
  late ReportQueriesService apiReportQuery;
  int i = 0;
  List<HistoryAllModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    apiReportQuery = ReportQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiReportQuery.getAllReport(pageAllHistory),
        builder:
            (BuildContext context, AsyncSnapshot<List<ReportModel>> snapshot) {
          if (snapshot.hasError) {
            // Get.dialog(FailedDialog(
            //     text: "Unknown error, please contact the admin",
            //     type: "error"));
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<ReportModel> contents = snapshot.data ?? [];
            return _buildListView(contents);
          } else {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<ReportModel> data) {
    if (data.isNotEmpty) {
      return Column(
        children: data.map<Widget>((dt) {
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
                    ComponentText(type: 'content_title', text: dt.reportTitle),
                    const Spacer(),
                    ComponentButton(type: 'button_tag', text: dt.reportCategory)
                  ],
                ),
                dt.reportDesc != ''
                    ? ComponentText(
                        type: 'content_body', text: dt.reportDesc ?? '-')
                    : const ComponentText(
                        type: 'no_data', text: 'No description provided'),
                const SizedBox(height: spaceMD),
                const ComponentText(type: 'content_sub_title', text: 'Items :'),
                dt.reportItems != ''
                    ? ComponentText(
                        type: 'content_body', text: dt.reportItems ?? '-')
                    : const ComponentText(
                        type: 'no_data', text: 'No items found'),
                const SizedBox(height: spaceMD),
                dt.reportCategory == 'Shopping Cart' ||
                        dt.reportCategory == 'Wishlist'
                    ? Row(
                        children: [
                          ComponentText(
                              type: 'content_title',
                              text: 'Total Price : Rp. ${dt.itemPrice}'),
                          const Spacer(),
                          ComponentText(
                              type: 'content_title',
                              text: 'Total Item : ${dt.totalItem}')
                        ],
                      )
                    : const SizedBox()
              ],
            ),
          );
        }).toList(),
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
