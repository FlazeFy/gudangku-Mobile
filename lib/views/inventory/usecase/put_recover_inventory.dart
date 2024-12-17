import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/service/commands.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/dialog/success_dialog.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';

class PostRecover extends StatefulWidget {
  final String id;
  final String inventoryName;
  final VoidCallback onReload;

  const PostRecover(
      {Key? key,
      required this.id,
      required this.inventoryName,
      required this.onReload})
      : super(key: key);

  @override
  StatePostRecover createState() => StatePostRecover();
}

class StatePostRecover extends State<PostRecover> {
  late InventoryCommandsService apiInventoryCommand;

  @override
  void initState() {
    super.initState();

    apiInventoryCommand = InventoryCommandsService();
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
                              type: 'content_title', text: 'Recovery'),
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
                            'Recover this item "${widget.inventoryName}"?',
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
                                          color: successBG, width: 1.5)),
                                ),
                                onPressed: () {
                                  apiInventoryCommand
                                      .putRecoverInventoryById(widget.id)
                                      .then((response) {
                                    setState(() => {});
                                    var status = response[0]['status'];
                                    var msg = response[0]['message'];

                                    if (status == "success") {
                                      widget.onReload();
                                      Get.dialog(SuccessDialog(text: msg));
                                    } else {
                                      Get.dialog(FailedDialog(
                                          text: msg, type: "recover"));
                                    }
                                  });
                                },
                                child: const Text('Yes, Recover'),
                              ),
                            ],
                          )
                        ]),
                      )
                    ]),
              ),
            ));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: spaceSM),
            decoration: BoxDecoration(
                border: Border.all(color: warningBG, width: 1),
                borderRadius:
                    const BorderRadius.all(Radius.circular(roundedMD))),
            child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.rotate,
                    size: textLG,
                  )
                ]),
          ),
        ));
  }
}
