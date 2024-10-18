import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/style.dart';

class ComponentText extends StatelessWidget {
  final String type;
  final String text;

  const ComponentText({super.key, required this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    if (type == 'table_text') {
      return Text(text, style: const TextStyle(fontSize: textSM));
    } else if (type == 'appbar_text') {
      return Text(text,
          style: const TextStyle(
              fontSize: textJumbo,
              fontWeight: FontWeight.bold,
              color: whiteColor));
    } else if (type == 'content_title') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceSM),
          child: Text(text,
              style: const TextStyle(
                  fontSize: textLG, fontWeight: FontWeight.w600)));
    } else if (type == 'content_sub_title') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceMini),
          child: Text(text,
              style: const TextStyle(
                  fontSize: textXMD, fontWeight: FontWeight.w500)));
    } else if (type == 'content_body') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceMini),
          child: Text(text,
              style: const TextStyle(
                  fontSize: textSM,
                  fontWeight: FontWeight.normal,
                  color: whiteColor)));
    } else if (type == 'no_data') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceMini),
          child: Text("- $text -",
              style: const TextStyle(
                  fontSize: textSM,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                  color: greyColor)));
    } else {
      return const Text("Default Title");
    }
  }
}
