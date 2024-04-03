import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/converter.dart';

class FailedDialog extends StatefulWidget {
  FailedDialog({this.text, this.type});
  // ignore: prefer_typing_uninitialized_variables
  final text; // Can be string or list
  final String? type;

  @override
  StateFailedDialog createState() => StateFailedDialog();
}

class StateFailedDialog extends State<FailedDialog> {
  @override
  Widget build(BuildContext context) {
    //double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(spaceSM),
      title: null,
      backgroundColor: darkColor,
      content: SizedBox(
        width: fullWidth,
        height: 320,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(roundedJumbo + roundedJumbo),
                child: Image.asset('assets/icon/Failed.png', width: 120),
              ),
              const SizedBox(height: spaceLG),
              const Text("Failed",
                  style:
                      TextStyle(fontSize: textLG, fontWeight: FontWeight.bold)),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, spaceMini, 0, spaceSM),
                  child: Text(
                      getMessageResponseFromObject(widget.text, widget.type),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: textXMD))),
              const Divider(
                height: spaceMD,
                color: greyColor,
              ),
              InkWell(
                  onTap: () => Navigator.pop(context, 'OK'),
                  child: Container(
                    padding: const EdgeInsets.all(spaceMD),
                    margin: const EdgeInsets.only(top: spaceMD),
                    decoration: const BoxDecoration(
                        color: dangerBG,
                        borderRadius:
                            BorderRadius.all(Radius.circular(roundedMD))),
                    child: const Text("Try Again",
                        style: TextStyle(
                            color: whiteColor, fontWeight: FontWeight.w500)),
                  ))
            ]),
      ),
    );
  }
}
