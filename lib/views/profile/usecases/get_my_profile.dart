import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/auth/model/queries.dart';
import 'package:gudangku/modules/api/auth/service/queries.dart';
import 'package:gudangku/modules/api/user/model/commands.dart';
import 'package:gudangku/modules/api/user/service/commands.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/dialog/success_dialog.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/input/label.dart';
import 'package:gudangku/modules/component/navbar.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/converter.dart';

class GetMyProfile extends StatefulWidget {
  const GetMyProfile({super.key});

  @override
  State<GetMyProfile> createState() => _GetMyProfileState();
}

class _GetMyProfileState extends State<GetMyProfile> {
  QueriesAuthServices? apiService;
  late UserCommandsService userCommand;
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController? telegramUserIdCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiService = QueriesAuthServices();
    userCommand = UserCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getMyProfile(),
        builder: (BuildContext context, AsyncSnapshot<ProfileModel?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            ProfileModel? contents = snapshot.data;

            return _buildListView(contents);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(ProfileModel? dt) {
    if (dt != null) {
      usernameCtrl!.text = dt.username;
    }
    if (dt != null) {
      emailCtrl!.text = dt.email;
    }
    if (dt != null && telegramUserIdCtrl != null) {
      telegramUserIdCtrl!.text = dt.telegramUserId;
    }

    return Column(children: [
      Container(
          margin: const EdgeInsets.only(
              left: spaceMD, right: spaceMD, bottom: spaceXMD),
          padding: const EdgeInsets.all(spaceMD),
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: spaceMini / 2),
              borderRadius: const BorderRadius.all(Radius.circular(roundedLG))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ComponentText(type: "content_title", text: "Profile"),
                Text("Joined since ${getItemTimeString(dt?.createdAt)}",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: textMD)),
                const SizedBox(height: spaceMD),
                getInputLabel("Username"),
                ComponentInput(
                    ctrl: usernameCtrl,
                    hinttext: "Username",
                    maxLength: 36,
                    type: 'text'),
                getInputLabel("Email"),
                ComponentInput(
                    ctrl: emailCtrl,
                    hinttext: "Email",
                    maxLength: 144,
                    type: 'text'),
                Container(
                    margin: const EdgeInsets.only(top: spaceMD),
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.save, color: whiteColor),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          )),
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(successBG),
                        ),
                        onPressed: () async {
                          String allMsg = "";
                          bool isValid = true;

                          if (usernameCtrl.text.isEmpty) {
                            isValid = false;
                            allMsg += 'the username cant be empty,';
                          }
                          if (usernameCtrl.text.length < 6) {
                            isValid = false;
                            allMsg += 'the username is not valid,';
                          }
                          if (emailCtrl.text.isEmpty) {
                            isValid = false;
                            allMsg += 'the email cant be empty,';
                          }
                          if (emailCtrl.text.length < 10) {
                            isValid = false;
                            allMsg += 'the email is not valid,';
                          }

                          if (isValid) {
                            UpdateProfileModel data = UpdateProfileModel(
                              username: usernameCtrl.text.trim(),
                              email: emailCtrl.text.trim(),
                            );
                            userCommand.putUpdateProfile(data).then((response) {
                              setState(() => {});

                              var status = response[0]['status'];
                              var msg = response[0]['message'];

                              if (status == "success") {
                                selectedIndex = 3;
                                Get.to(const BottomBar());
                                Get.dialog(SuccessDialog(text: msg));
                              } else {
                                if (msg is! String) {
                                } else {
                                  allMsg = msg;
                                }
                                Get.dialog(FailedDialog(
                                    text: allMsg, type: "editprofile"));
                              }
                            });
                          } else {
                            Get.dialog(FailedDialog(text: allMsg, type: null));
                          }
                        },
                        label: const Text("Save Changes",
                            style:
                                TextStyle(fontSize: 15, color: whiteColor)))),
              ])),
      Container(
          margin: const EdgeInsets.only(
              left: spaceMD, right: spaceMD, bottom: spaceXMD),
          padding: const EdgeInsets.all(spaceMD),
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: spaceMini / 2),
              borderRadius: const BorderRadius.all(Radius.circular(roundedLG))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ComponentText(
                    type: "content_title", text: "Telegram Account"),
                getInputLabel("Telegram User ID"),
                ComponentInput(
                    ctrl: telegramUserIdCtrl,
                    hinttext: "Telegram User ID",
                    maxLength: 36,
                    type: 'text'),
              ]))
    ]);
  }
}
