import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/model/queries.dart';
import 'package:gudangku/modules/api/inventory/service/commands.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/dialog/success_dialog.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/input/label.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/detail_inventory/index.dart';
import 'package:gudangku/views/others/get_dct.dart';

class PostReminder extends StatefulWidget {
  const PostReminder(
      {super.key,
      required this.isExist,
      required this.id,
      required this.inventoryName});
  final bool isExist;
  final String id;
  final String inventoryName;

  @override
  StatePostReminder createState() => StatePostReminder();
}

class StatePostReminder extends State<PostReminder> {
  TextEditingController reminderDescCtrl = TextEditingController();
  String selectedReminderType = '-';
  String selectedReminderContext = '-';
  bool isLoadPost = false;
  String allMsg = "";
  bool sendDemo = false;
  late InventoryCommandsService apiCommand;

  @override
  void initState() {
    super.initState();
    apiCommand = InventoryCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: spaceMD),
        padding: const EdgeInsets.all(spaceXMD),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(roundedLG),
          color: primaryColor.withOpacity(0.25),
        ),
        child: Row(children: [
          const FaIcon(
            FontAwesomeIcons.clock,
            color: whiteColor,
            size: textXJumbo * 1.75,
          ),
          const SizedBox(
            width: spaceLG,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ComponentText(
                  type: "content_sub_title",
                  text: "This item doesn't asigned in any report"),
              const SizedBox(
                height: spaceSM,
              ),
              InkWell(
                  onTap: (() {
                    Get.dialog(AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      title: null,
                      backgroundColor: darkColor,
                      content: SizedBox(
                        width: Get.width,
                        height: 585,
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
                                      text: "Add Reminder"),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      foregroundColor:
                                          MaterialStateProperty.all(whiteColor),
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
                                              color: dangerBG, width: 1.5)),
                                    ),
                                    onPressed: () => Get.back(),
                                  ),
                                ]),
                              ),
                              const Divider(),
                              Container(
                                padding: const EdgeInsets.all(spaceSM),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ComponentText(
                                          type: "content_sub_title",
                                          text:
                                              "using item : ${widget.inventoryName}"),
                                      const SizedBox(height: spaceMD),
                                      getInputLabel("Description"),
                                      ComponentInput(
                                        ctrl: reminderDescCtrl,
                                        hinttext:
                                            "ex : its time to restock at nearest minimart",
                                        maxLength: 255,
                                        type: 'text',
                                        maxLines: 5,
                                      ),
                                      getInputLabel("Type"),
                                      GetAllDctByType(
                                          type: 'reminder_type',
                                          selected: selectedReminderType,
                                          action: (value) {
                                            setState(() {
                                              selectedReminderType = value;
                                            });
                                          }),
                                      getInputLabel("Category"),
                                      GetAllDctByType(
                                          type: 'reminder_context',
                                          selected: selectedReminderContext,
                                          action: (value) {
                                            setState(() {
                                              selectedReminderContext = value;
                                            });
                                          }),
                                      ComponentInput(
                                          ctrl: sendDemo,
                                          type: 'checkbox',
                                          hinttext: 'Send me the Demo',
                                          action: (bool? value) {
                                            setState(() {
                                              sendDemo = value!;
                                            });
                                          }),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              top: spaceMD, bottom: spaceJumbo),
                                          child: InkWell(
                                            child: const ComponentButton(
                                              type: 'button_success',
                                              text: 'Submit',
                                              icon: FaIcon(
                                                  FontAwesomeIcons.floppyDisk,
                                                  color: whiteColor,
                                                  size: textLG),
                                            ),
                                            onTap: () {
                                              if (isLoadPost == false) {
                                                setState(() {
                                                  isLoadPost = true;
                                                });
                                                bool isValid = true;

                                                if (reminderDescCtrl
                                                    .text.isEmpty) {
                                                  isValid = false;
                                                  allMsg +=
                                                      'the desc cant be empty,';
                                                }

                                                if (isValid) {
                                                  ReminderModel data =
                                                      ReminderModel(
                                                    inventoryId: widget.id,
                                                    reminderDesc:
                                                        reminderDescCtrl.text
                                                            .trim(),
                                                    reminderType:
                                                        selectedReminderType,
                                                    reminderContext:
                                                        selectedReminderContext,
                                                    sendDemo: sendDemo ? 1 : 0,
                                                  );
                                                  apiCommand
                                                      .postReminder(data)
                                                      .then((response) {
                                                    setState(() => {});
                                                    print(response);
                                                    var status =
                                                        response[0]['status'];
                                                    var msg =
                                                        response[0]['message'];

                                                    if (status == "success") {
                                                      Get.to(EditInventoryPage(
                                                          id: widget.id));

                                                      Get.dialog(SuccessDialog(
                                                          text: msg));
                                                    } else {
                                                      if (msg is! String) {
                                                      } else {
                                                        allMsg = msg;
                                                      }
                                                      Get.dialog(FailedDialog(
                                                          text: allMsg,
                                                          type: "addreminder"));
                                                    }
                                                  });
                                                } else {
                                                  Get.dialog(FailedDialog(
                                                      text: allMsg,
                                                      type: null));
                                                }

                                                setState(() {
                                                  allMsg = "";
                                                  isLoadPost = false;
                                                });
                                              }
                                            },
                                          )),
                                    ]),
                              )
                            ]),
                      ),
                    ));
                  }),
                  child: const ComponentButton(
                    type: "button_primary",
                    text: "Add New Reminder",
                    icon: FaIcon(
                      FontAwesomeIcons.plus,
                      color: whiteColor,
                      size: textLG,
                    ),
                  ))
            ],
          )
        ]));
  }
}
