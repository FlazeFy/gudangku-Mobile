import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/service/commands.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/navbar.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';

class HardDeleteInventory extends StatefulWidget {
  final String id;
  final String inventoryName;

  const HardDeleteInventory(
      {Key? key, required this.id, required this.inventoryName})
      : super(key: key);

  @override
  StateHardDeleteInventory createState() => StateHardDeleteInventory();
}

class StateHardDeleteInventory extends State<HardDeleteInventory> {
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
                              type: 'content_title',
                              text: 'Permentally Delete'),
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
                            'Permentally Delete this item "${widget.inventoryName}"?',
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
                                  apiInventoryCommand
                                      .hardDeleteInventoryById(widget.id)
                                      .then((response) {
                                    setState(() => {});
                                    var status = response[0]['message'];
                                    var body = response[0]['body'];

                                    if (status == "success") {
                                      Get.to(const BottomBar());
                                    } else {
                                      Get.dialog(FailedDialog(
                                          text: body, type: "deleteinventory"));
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
