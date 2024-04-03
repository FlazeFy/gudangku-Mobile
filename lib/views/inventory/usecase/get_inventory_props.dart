import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/service/commands.dart';
import 'package:gudangku/modules/global/style.dart';

class PropsInventory extends StatefulWidget {
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  const PropsInventory(
      {Key? key,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt})
      : super(key: key);

  @override
  StatePropsInventory createState() => StatePropsInventory();
}

class StatePropsInventory extends State<PropsInventory> {
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
                height: 280,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: spaceMD, right: spaceMD, top: spaceMD),
                        child: Row(children: [
                          const Text("Properties",
                              style: TextStyle(
                                  fontSize: textLG,
                                  fontWeight: FontWeight.w600)),
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
                            left: spaceMD, right: spaceMD, bottom: spaceXMD),
                        child: Column(children: [
                          const Text(
                            'Created At',
                          ),
                          Text(
                            widget.createdAt ?? "-",
                          ),
                          const SizedBox(height: spaceMD),
                          const Text(
                            'Updated At',
                          ),
                          Text(
                            widget.updatedAt != "" ? widget.updatedAt : "-",
                          ),
                          const SizedBox(height: spaceMD),
                          const Text(
                            'Deleted At',
                          ),
                          Text(
                            widget.deletedAt != "" ? widget.deletedAt : "-",
                          ),
                        ]),
                      )
                    ]),
              ),
            ));
          },
          icon: const FaIcon(FontAwesomeIcons.info),
          padding: const EdgeInsets.only(bottom: spaceLG),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.all(whiteColor),
            side: MaterialStateProperty.all(
                const BorderSide(color: primaryColor, width: 1.5)),
          ),
        ));
  }
}
