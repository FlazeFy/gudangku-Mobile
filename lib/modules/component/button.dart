import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/style.dart';

class ComponentButton extends StatelessWidget {
  final String type;
  final String text;
  final dynamic icon;

  const ComponentButton(
      {super.key, required this.type, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    if (type == 'button_tag' || type == 'button_tag_secondary') {
      return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: spaceMD, vertical: spaceMini),
        decoration: BoxDecoration(
            color: type == 'button_tag'
                ? successBG
                : type == 'button_tag_secondary'
                    ? primaryColor
                    : dangerBG,
            borderRadius: const BorderRadius.all(Radius.circular(roundedLG))),
        child: Text(text,
            style: const TextStyle(
                color: whiteColor,
                fontSize: textXMD,
                fontWeight: FontWeight.w500)),
      );
    } else if (type == 'button_text') {
      return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: spaceMD, vertical: spaceMini),
        child: Text(text,
            style: const TextStyle(
                color: whiteColor,
                fontSize: textXMD,
                fontWeight: FontWeight.w500)),
      );
    } else if (type == 'button_primary') {
      return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: spaceXMD, vertical: spaceSM),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 2, color: primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(roundedLG))),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  if (icon != null)
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: spaceMini),
                        child: icon,
                      ),
                    ),
                  TextSpan(
                    text: text,
                    style: const TextStyle(
                      color: whiteColor,
                      fontSize: textLG,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )));
    } else if (type == 'button_success' ||
        type == 'button_danger' ||
        type == 'button_warning') {
      return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: spaceXMD, vertical: spaceSM),
          decoration: BoxDecoration(
              color: type == 'button_success'
                  ? successBG
                  : type == 'button_danger'
                      ? dangerBG
                      : type == 'button_warning'
                          ? warningBG
                          : primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(roundedLG))),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  if (icon != null)
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: spaceMini),
                        child: icon,
                      ),
                    ),
                  TextSpan(
                    text: text,
                    style: const TextStyle(
                      color: whiteColor,
                      fontSize: textLG,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )));
    } else {
      return const Text("Default Title");
    }
  }
}
