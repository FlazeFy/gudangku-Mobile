import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/report/service/commands.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/dialog/success_dialog.dart';
import 'package:gudangku/modules/component/navbar.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';

class DeleteReport extends StatefulWidget {
  final String id;

  const DeleteReport({Key? key, required this.id}) : super(key: key);

  @override
  StateDeleteReport createState() => StateDeleteReport();
}

class StateDeleteReport extends State<DeleteReport> {
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
        child: InkWell(
          onTap: () {
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
                          const Text(
                            'Are you sure want to Permentally Delete this report?',
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
                                      .deleteReportById(widget.id)
                                      .then((response) {
                                    setState(() => {});
                                    var status = response[0]['status'];
                                    var msg = response[0]['message'];

                                    if (status == "success") {
                                      selectedIndex = 2;
                                      Get.to(const BottomBar());
                                      Get.dialog(SuccessDialog(text: msg));
                                    } else {
                                      Get.dialog(FailedDialog(
                                          text: msg, type: "deletereport"));
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
          child: const ComponentButton(
              type: 'button_danger',
              text: 'Delete',
              icon: FaIcon(FontAwesomeIcons.trash,
                  color: whiteColor, size: textLG)),
        ));
  }
}
