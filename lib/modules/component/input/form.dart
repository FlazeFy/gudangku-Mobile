import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/style.dart';

Widget getInputTextMain(ctrl, String title, int len, bool secure) {
  return Container(
    padding: EdgeInsets.zero,
    child: TextFormField(
      obscureText: secure,
      cursorColor: Colors.white,
      controller: ctrl,
      maxLength: len,
      style: const TextStyle(
          color: whiteColor, fontWeight: FontWeight.w400, fontSize: textXMD),
      decoration: InputDecoration(
        hintStyle:
            const TextStyle(color: whiteColor, fontStyle: FontStyle.italic),
        helperStyle: const TextStyle(color: whiteColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        hintText: title,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2.5, color: successBG),
        ),
      ),
    ),
  );
}
