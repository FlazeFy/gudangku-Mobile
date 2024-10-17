import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/history/model/queries.dart';
import 'package:gudangku/modules/api/history/service/queries.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/history/usecase/hard_delete_history.dart';

class GetAllHistory extends StatefulWidget {
  const GetAllHistory({super.key});

  @override
  StateGetAllHistory createState() => StateGetAllHistory();
}

class StateGetAllHistory extends State<GetAllHistory> {
  late HistoryQueriesService apiHistoryQuery;
  int i = 0;
  List<HistoryAllModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    apiHistoryQuery = HistoryQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiHistoryQuery.getAllHistory(pageAllHistory),
        builder: (BuildContext context,
            AsyncSnapshot<List<HistoryAllModel>> snapshot) {
          if (snapshot.hasError) {
            // Get.dialog(FailedDialog(
            //     text: "Unknown error, please contact the admin",
            //     type: "error"));
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<HistoryAllModel> contents = snapshot.data ?? [];
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

  Widget _buildListView(List<HistoryAllModel> data) {
    if (data.isNotEmpty) {
      return Column(
        children: data.map<Widget>((e) {
          return Container(
            padding: const EdgeInsets.all(spaceMD),
            decoration: BoxDecoration(
                border: Border.all(width: spaceMini / 2, color: primaryColor),
                borderRadius:
                    const BorderRadius.all(Radius.circular(roundedLG))),
            margin: const EdgeInsets.only(bottom: spaceMD),
            child: Row(
              children: [
                SizedBox(
                    width: Get.width * 0.75,
                    child: Text(
                      "${e.historyType} ${e.historyContext}",
                    )),
                const Spacer(),
                HardDeleteHistory(
                    id: e.id, ctx: "${e.historyType} ${e.historyContext}")
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
