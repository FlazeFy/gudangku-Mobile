import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/auth/service/commands.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/dialog/success_dialog.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/template.dart';

class PostSignOut extends StatefulWidget {
  const PostSignOut({Key? key}) : super(key: key);

  @override
  StatePostSignOutState createState() => StatePostSignOutState();
}

class StatePostSignOutState extends State<PostSignOut> {
  late AuthCommandsService apiCommand;

  @override
  void initState() {
    super.initState();

    apiCommand = AuthCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(left: spaceMD, right: spaceMD, bottom: spaceMD),
      decoration: BoxDecoration(
          color: dangerBG,
          border: Border.all(color: whiteColor, width: spaceMini / 2),
          borderRadius: const BorderRadius.all(Radius.circular(roundedLG))),
      child: ListTile(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: spaceMD, right: spaceMD, top: spaceMD),
                      child: Row(children: [
                        const Text("Sign Out",
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
                        const Text(
                          'Are you sure want to leave this account?',
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
                                apiCommand.postSignOut().then((response) async {
                                  setState(() => {});
                                  var status = response[0]['status'];
                                  var msg = response[0]['message'];

                                  if (status == "success") {
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      getDestroyTrace(true);
                                    });
                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      Get.dialog(SuccessDialog(text: msg));
                                    });
                                  } else {
                                    Get.dialog(FailedDialog(
                                        text: msg, type: "signOut"));
                                  }
                                });
                              },
                              child: const Text('Yes, Sign Out'),
                            ),
                          ],
                        )
                      ]),
                    )
                  ]),
            ),
          ));
        },
        leading:
            const FaIcon(FontAwesomeIcons.rightFromBracket, color: whiteColor),
        title: const Text('Sign Out',
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
