import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gudangku/modules/global/style.dart';

class ComponentContainer extends StatelessWidget {
  final String type;
  final String text;
  final Color color;
  final Color textColor;
  final dynamic icon;

  const ComponentContainer(
      {super.key,
      required this.type,
      required this.color,
      required this.text,
      required this.textColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    if (type == 'info_box') {
      return Container(
        padding: const EdgeInsets.all(spaceXMD),
        margin: const EdgeInsets.only(bottom: spaceMD),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(roundedLG))),
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: FaIcon(
                  icon,
                  size: textXMD,
                  color: darkColor,
                ),
              ),
              TextSpan(
                  text: " $text",
                  style: TextStyle(
                      color: textColor,
                      fontSize: textXMD,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
