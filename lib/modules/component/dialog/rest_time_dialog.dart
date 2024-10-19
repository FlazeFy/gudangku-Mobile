import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';

Widget getRestTimeDialog(String ctx, int time) {
  return IconButton(
    icon: const FaIcon(
      FontAwesomeIcons.circleInfo,
      color: whiteColor,
    ),
    tooltip: 'Show Snackbar',
    onPressed: () {
      Get.dialog(AlertDialog(
        contentPadding: EdgeInsets.zero,
        title: null,
        backgroundColor: darkColor,
        content: SizedBox(
          width: Get.width,
          height: 150,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: spaceMD, right: spaceMD, top: spaceMD),
                  child: Row(children: [
                    const ComponentText(
                        type: 'content_title', text: 'Information'),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        foregroundColor: MaterialStateProperty.all(whiteColor),
                        side: MaterialStateProperty.all(
                            const BorderSide(color: dangerBG, width: 1.5)),
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ]),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(spaceMD),
                  child: ComponentText(
                      type: 'content_sub_title',
                      text:
                          '$ctx will refresh every ${(time / 60).ceil()} minutes after last time you access this page'),
                )
              ]),
        ),
      ));
    },
  );
}
