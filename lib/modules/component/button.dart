import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/style.dart';

class ComponentButton extends StatelessWidget {
  final String type;
  final String text;

  const ComponentButton({super.key, required this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    if (type == 'button_tag') {
      return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: spaceMD, vertical: spaceMini),
        decoration: const BoxDecoration(
            color: successBG,
            borderRadius: BorderRadius.all(Radius.circular(roundedLG))),
        child: Text(text,
            style: const TextStyle(
                color: whiteColor,
                fontSize: textXMD,
                fontWeight: FontWeight.w500)),
      );
    } else {
      return const Text("Default Title");
    }
  }
}
