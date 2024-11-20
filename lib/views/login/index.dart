import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/login/usecases/post_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: const Column(children: [
                Text("Welcome to GudangKu",
                    style: TextStyle(
                        fontSize: textJumbo, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Manage your home inventory", textAlign: TextAlign.center),
              ])),
          const PostLogin(),
          const Text("New user? please register first to use this app",
              textAlign: TextAlign.center, style: TextStyle(color: whiteColor)),
          Container(
              margin: const EdgeInsets.only(top: spaceSM),
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(primaryColor),
                  ),
                  onPressed: () {},
                  child:
                      const Text("Register", style: TextStyle(fontSize: 15)))),
          const SizedBox(height: spaceLG),
          const FooterBar()
        ],
      ),
    );
  }
}
