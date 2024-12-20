import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gudangku/modules/api/inventory/model/queries.dart';
import 'package:gudangku/modules/api/inventory/service/queries.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';

class GetAllNotification extends StatefulWidget {
  const GetAllNotification({super.key});

  @override
  StateGetAllNotification createState() => StateGetAllNotification();
}

class StateGetAllNotification extends State<GetAllNotification> {
  late InventoryQueriesService apiInventoryQuery;
  List<NotificationModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    apiInventoryQuery = InventoryQueriesService();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    var data = await apiInventoryQuery.getAllNotification(pageAllNotification);
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

  Widget _buildListView(List<NotificationModel> data) {
    if (data.isNotEmpty) {
      return Column(
        children: data.map((e) {
          return Container(
            padding: const EdgeInsets.all(spaceMD),
            decoration: BoxDecoration(
                border: Border.all(width: spaceMini / 2, color: whiteColor),
                borderRadius:
                    const BorderRadius.all(Radius.circular(roundedLG))),
            margin: const EdgeInsets.only(bottom: spaceMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: whiteColor, width: 1.5),
                            borderRadius: BorderRadius.circular(roundedMD)),
                        padding: const EdgeInsets.all(spaceXSM),
                        child: const FaIcon(FontAwesomeIcons.bell,
                            color: whiteColor)),
                    const SizedBox(
                      width: spaceSM,
                    ),
                    ComponentText(
                        type: 'content_sub_title', text: e.reminderDesc),
                  ],
                ),
                const SizedBox(height: spaceSM),
                ComponentText(
                    type: 'content_body',
                    color: greyColor,
                    fstyle: FontStyle.italic,
                    text: "Received At : ${e.lastExecute}")
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
