import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/report/model/commands.dart';
import 'package:gudangku/modules/api/report/model/queries.dart';
import 'package:gudangku/modules/api/report/service/commands.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/input/label.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/detail_report/index.dart';
import 'package:gudangku/views/others/get_dct.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

class PutDetailReport extends StatefulWidget {
  const PutDetailReport({super.key, required this.id, required this.data});
  final String id;
  final ReportDetailModel data;

  @override
  StatePutDetailReport createState() => StatePutDetailReport();
}

class StatePutDetailReport extends State<PutDetailReport> {
  TextEditingController reportTitleCtrl = TextEditingController();
  TextEditingController reportDescCtrl = TextEditingController();
  bool isLoadPost = false;
  String allMsg = "";

  late ReportCommandsService apiCommand;

  @override
  void initState() {
    super.initState();
    apiCommand = ReportCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    String selectedReportCategory = widget.data.reportCategory;
    reportTitleCtrl.text = widget.data.reportTitle;
    reportDescCtrl.text = widget.data.reportDesc ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getInputLabel("Title"),
        ComponentInput(ctrl: reportTitleCtrl, maxLength: 36, type: 'text'),
        getInputLabel("Category"),
        GetAllDctByType(
            type: 'report_category',
            selected: selectedReportCategory,
            action: (value) {
              setState(() {
                selectedReportCategory = value;
              });
            }),
        getInputLabel("Description"),
        ComponentInput(
          ctrl: reportDescCtrl,
          maxLength: 255,
          type: 'text',
          maxLines: 5,
        ),
        Container(
            margin: const EdgeInsets.only(top: spaceMD, bottom: spaceJumbo),
            child: InkWell(
              child: const ComponentButton(
                type: 'button_success',
                text: 'Save Changes',
                icon: FaIcon(FontAwesomeIcons.floppyDisk,
                    color: whiteColor, size: textLG),
              ),
              onTap: () {
                if (isLoadPost == false) {
                  setState(() {
                    isLoadPost = true;
                  });
                  bool isValid = true;

                  if (reportTitleCtrl.text.isEmpty) {
                    isValid = false;
                    allMsg += 'the title cant be empty,';
                  }
                  if (selectedReportCategory == '-') {
                    isValid = false;
                    allMsg += 'the category cant be empty,';
                  }

                  if (isValid) {
                    PutReportDetailModel data = PutReportDetailModel(
                        reportTitle: reportTitleCtrl.text.trim(),
                        reportCategory: selectedReportCategory,
                        reportDesc: reportDescCtrl.text.trim());
                    apiCommand.putReportById(data, widget.id).then((response) {
                      setState(() => {});
                      var status = response[0]['status'];
                      var msg = response[0]['message'];

                      if (status == "success") {
                        ArtSweetAlert.show(
                            context: context,
                            artDialogArgs: ArtDialogArgs(
                                showCancelBtn: false,
                                onConfirm: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailReportPage(id: widget.id)),
                                  );
                                },
                                type: ArtSweetAlertType.success,
                                title: "Success",
                                text: msg));
                      } else {
                        if (msg is! String) {
                        } else {
                          allMsg = msg;
                        }
                        Get.dialog(FailedDialog(
                            text: allMsg, type: "putreminderbyid"));
                      }
                    });
                  } else {
                    Get.dialog(FailedDialog(text: allMsg, type: null));
                  }

                  setState(() {
                    allMsg = "";
                    isLoadPost = false;
                  });
                }
              },
            )),
      ],
    );
  }
}
