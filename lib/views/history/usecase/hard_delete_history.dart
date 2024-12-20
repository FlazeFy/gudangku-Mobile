import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/History/service/commands.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/dialog/success_dialog.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HardDeleteHistory extends StatefulWidget {
  final String id;
  final String ctx;
  final VoidCallback onReload;

  const HardDeleteHistory(
      {Key? key, required this.id, required this.ctx, required this.onReload})
      : super(key: key);

  @override
  StateHardDeleteHistory createState() => StateHardDeleteHistory();
}

class StateHardDeleteHistory extends State<HardDeleteHistory> {
  late HistoryCommandsService apiHistoryCommand;

  @override
  void initState() {
    super.initState();

    apiHistoryCommand = HistoryCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: spaceMD, right: spaceMD, top: spaceMD),
                    child: Row(children: [
                      const Text("Permentally Delete",
                          style: TextStyle(
                              fontSize: textLG, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          foregroundColor:
                              MaterialStateProperty.all(whiteColor),
                          side: MaterialStateProperty.all(
                              const BorderSide(color: dangerBG, width: 1.5)),
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
                        'Permentally Delete this history "${widget.ctx}"?',
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: spaceMD),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              foregroundColor:
                                  MaterialStateProperty.all(whiteColor),
                              side: MaterialStateProperty.all(const BorderSide(
                                  color: dangerBG, width: 1.5)),
                            ),
                            onPressed: () {
                              apiHistoryCommand
                                  .hardDeleteHistoryById(widget.id)
                                  .then((response) async {
                                setState(() => {});
                                var status = response[0]['status'];
                                var msg = response[0]['message'];

                                if (status == "success") {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.remove("last-hit-history-sess");
                                  widget.onReload();
                                  Get.back();
                                  Get.dialog(SuccessDialog(text: msg));
                                } else {
                                  Get.dialog(FailedDialog(
                                      text: msg, type: "deleteHistory"));
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
      icon: const FaIcon(
        FontAwesomeIcons.trash,
        size: textLG,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(whiteColor),
        side: MaterialStateProperty.all(
            const BorderSide(color: dangerBG, width: 1.5)),
      ),
    );
  }
}
