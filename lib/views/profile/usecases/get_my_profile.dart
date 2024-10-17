import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/auth/model/queries.dart';
import 'package:gudangku/modules/api/auth/service/queries.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/input/label.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/converter.dart';

class GetMyProfile extends StatefulWidget {
  const GetMyProfile({super.key});

  @override
  State<GetMyProfile> createState() => _GetMyProfileState();
}

class _GetMyProfileState extends State<GetMyProfile> {
  QueriesAuthServices? apiService;
  TextEditingController? usernameCtrl = TextEditingController();
  TextEditingController? emailCtrl = TextEditingController();
  TextEditingController? telegramUserIdCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiService = QueriesAuthServices();
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

    return Container(
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
              Text("Joined since ${getItemTimeString(dt?.createdAt)}",
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: textMD)),
              const SizedBox(height: spaceMD),
              getInputLabel("Username"),
              getInputTextMain(usernameCtrl, "Username", 36, false),
              getInputLabel("Email"),
              getInputTextMain(emailCtrl, "Email", 144, false),
              getInputLabel("Telegram User ID"),
              getInputTextMain(
                  telegramUserIdCtrl, "Telegram User ID", 36, false),
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
                      onPressed: () async {},
                      label: const Text("Save Changes",
                          style: TextStyle(fontSize: 15, color: whiteColor)))),
            ]));
  }
}
