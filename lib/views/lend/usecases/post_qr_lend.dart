import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/user/service/commands.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/container.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/global/style.dart';

class PostQRCode extends StatefulWidget {
  const PostQRCode({Key? key}) : super(key: key);

  @override
  StatePostQRCodeState createState() => StatePostQRCodeState();
}

class StatePostQRCodeState extends State<PostQRCode> {
  late UserCommandsService apiCommand;
  Map<String, dynamic>? qrData;

  @override
  void initState() {
    super.initState();

    apiCommand = UserCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      qrData == null
          ? const ComponentContainer(
              type: "info_box",
              color: successLightBG,
              textColor: darkColor,
              icon: FontAwesomeIcons.circleInfo,
              text: "The last QR Code is already expired. Generate a new one?")
          : Container(
              padding: const EdgeInsets.all(spaceXMD),
              margin: const EdgeInsets.only(bottom: spaceMD, top: spaceMD),
              decoration: const BoxDecoration(
                color: successLightBG,
                borderRadius: BorderRadius.all(Radius.circular(roundedLG)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    qrData!['lend_qr_url'],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 80),
                  ),
                  const SizedBox(height: spaceMD),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: FaIcon(
                            FontAwesomeIcons.circleInfo,
                            size: textXMD,
                            color: darkColor,
                          ),
                        ),
                        TextSpan(
                          text:
                              " QR is Active! for ${qrData!['qr_period']} hours from now, people with this QR can see your inventory list and ask for permission to borrow until ${qrData!['lend_expired_datetime']}.",
                          style: const TextStyle(
                            color: darkColor,
                            fontSize: textXMD,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: spaceMD),
                  const Text(
                    "Be carefull to lend your items to strangers!",
                    style: TextStyle(
                      color: darkColor,
                      fontSize: textXMD,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
      ComponentButton(
        type: "button_tile",
        text: "Generate QR Code",
        icon: FontAwesomeIcons.qrcode,
        action: () => {
          apiCommand.generateQRCode().then((response) async {
            setState(() => {});
            var status = response[0]['status'];

            if (status == "success") {
              var data = response[0]['data'];
              setState(() {
                qrData = data;
              });
              // Future.delayed(const Duration(seconds: 3), () {
              //   Get.dialog(SuccessDialog(text: msg));
              // });
            } else {
              var msg = response[0]['message'];

              Get.dialog(FailedDialog(text: msg, type: "signOut"));
            }
          })
        },
      )
    ]);
  }
}
