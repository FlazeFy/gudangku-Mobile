import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/history/model/queries.dart';
import 'package:gudangku/modules/api/history/service/queries.dart';
import 'package:gudangku/modules/component/text.dart';
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
  List<HistoryAllModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    apiHistoryQuery = HistoryQueriesService();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    var data = await apiHistoryQuery.getAllHistory(pageAllHistory);
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

  Widget _buildListView(List<HistoryAllModel> data) {
    if (data.isNotEmpty) {
      return Column(
        children: data.map((e) {
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ComponentText(
                            type: 'content_sub_title',
                            text: "${e.historyType} ${e.historyContext}"),
                        ComponentText(
                            type: 'content_body',
                            color: greyColor,
                            fstyle: FontStyle.italic,
                            text: "Created At : ${e.createdAt}")
                      ]),
                ),
                const Spacer(),
                HardDeleteHistory(
                  id: e.id,
                  ctx: "${e.historyType} ${e.historyContext}",
                  onReload: loadData,
                ),
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
