import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/auth/model/commands.dart';
import 'package:gudangku/modules/api/auth/service/commands.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/input/label.dart';
import 'package:gudangku/modules/component/navbar.dart';
import 'package:gudangku/modules/global/style.dart';

class PostLogin extends StatefulWidget {
  const PostLogin({super.key});

  @override
  State<PostLogin> createState() => _PostLoginState();
}

class _PostLoginState extends State<PostLogin> {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  late LoginCommandsService apiService;

  @override
  void initState() {
    super.initState();
    apiService = LoginCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(spaceLG),
      margin: const EdgeInsets.all(spaceSM + spaceLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getInputLabel("Email Address or Username"),
          ComponentInput(
              ctrl: usernameCtrl,
              hinttext: "example.com / personabc",
              maxLength: 35,
              type: 'email'),
          getInputLabel("Password"),
          ComponentInput(
              ctrl: passCtrl,
              hinttext: "password",
              maxLength: 35,
              secure: true,
              type: 'text'),
          Container(
              margin: const EdgeInsets.only(top: spaceSM),
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.login,
                    color: whiteColor,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(successBG),
                  ),
                  onPressed: () async {
                    LoginModel data = LoginModel(
                      username: usernameCtrl.text,
                      password: passCtrl.text,
                    );

                    //Validator
                    if (data.username.isNotEmpty && data.password.isNotEmpty) {
                      apiService.postLogin(data).then((response) {
                        setState(() {});
                        var status = response[0]['message'];
                        var body = response[0]['body'];

                        if (status == "success") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomBar()),
                          );
                        } else {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  FailedDialog(text: body));

                          usernameCtrl.clear();
                          passCtrl.clear();
                        }
                      });
                    } else {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => const FailedDialog(
                              text: "Login failed, field can't be empty"));
                    }
                  },
                  label: const Text("Sign In",
                      style: TextStyle(fontSize: 15, color: whiteColor)))),
        ],
      ),
    );
  }
}
