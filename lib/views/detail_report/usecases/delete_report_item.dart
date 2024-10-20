import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/service/commands.dart';
import 'package:gudangku/modules/api/report/service/commands.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/dialog/success_dialog.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';

class DeleteReportItem extends StatefulWidget {
  final String id;
  final String inventoryName;
  final String reportTitle;
  final VoidCallback onReload;

  const DeleteReportItem(
      {Key? key,
      required this.id,
      required this.inventoryName,
      required this.reportTitle,
      required this.onReload})
      : super(key: key);

  @override
  StateDeleteReportItem createState() => StateDeleteReportItem();
}

class StateDeleteReportItem extends State<DeleteReportItem> {
  late ReportCommandsService apiReportCommand;

  @override
  void initState() {
    super.initState();

    apiReportCommand = ReportCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(spaceSM),
        child: IconButton(
          onPressed: () {
            Get.dialog(AlertDialog(
              contentPadding: EdgeInsets.zero,
              title: null,
              backgroundColor: darkColor,
              content: SizedBox(
                width: Get.width,
                height: 200,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: spaceMD, right: spaceMD, top: spaceMD),
                        child: Row(children: [
                          const ComponentText(
                              type: 'content_title', text: 'Delete'),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              foregroundColor:
                                  MaterialStateProperty.all(whiteColor),
                              side: MaterialStateProperty.all(const BorderSide(
                                  color: dangerBG, width: 1.5)),
                            ),
                            onPressed: () => Get.back(),
                          ),
                        ]),
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.only(
                            left: spaceMD, right: spaceMD, bottom: spaceMD),
                        child: Column(children: [
                          const SizedBox(height: spaceMD),
                          Text(
                            'Remove this item "${widget.inventoryName}" from report "${widget.reportTitle}"?',
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: spaceMD),
                          Row(
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  foregroundColor:
                                      MaterialStateProperty.all(whiteColor),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                          color: dangerBG, width: 1.5)),
                                ),
                                onPressed: () {
                                  apiReportCommand
                                      .deleteReportInventoryById(widget.id)
                                      .then((response) {
                                    setState(() => {});
                                    var status = response[0]['status'];
                                    var msg = response[0]['message'];

                                    if (status == "success") {
                                      widget.onReload();
                                      Get.back();
                                      Get.dialog(SuccessDialog(text: msg));
                                    } else {
                                      Get.dialog(FailedDialog(
                                          text: msg,
                                          type: "deletereportinventory"));
                                    }
                                  });
                                },
                                child: const Text('Yes, Delete'),
                              ),
                            ],
                          )
                        ]),
                      )
                    ]),
              ),
            ));
          },
          icon: const FaIcon(FontAwesomeIcons.fire),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.all(whiteColor),
            side: MaterialStateProperty.all(
                const BorderSide(color: dangerBG, width: 1.5)),
          ),
        ));
  }
}
