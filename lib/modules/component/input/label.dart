import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/style.dart';

Widget getInputLabel(String title) {
  return Container(
      margin: const EdgeInsets.only(bottom: spaceMini),
      alignment: Alignment.topLeft,
      child: Text(title, style: const TextStyle()));
}
