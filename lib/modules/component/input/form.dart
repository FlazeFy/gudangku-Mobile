import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/style.dart';

class ComponentInput extends StatelessWidget {
  final dynamic ctrl;
  final String type;
  final String hinttext;
  final bool? secure;
  final int? maxLength;
  final int? minLength;

  const ComponentInput(
      {super.key,
      required this.ctrl,
      required this.type,
      required this.hinttext,
      this.secure,
      this.maxLength,
      this.minLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: TextFormField(
        obscureText: secure ?? false,
        cursorColor: whiteColor,
        controller: ctrl,
        keyboardType:
            type == 'number' ? TextInputType.number : TextInputType.text,
        maxLength: maxLength ?? 255,
        style: const TextStyle(
            color: whiteColor, fontWeight: FontWeight.w400, fontSize: textXMD),
        decoration: InputDecoration(
          hintStyle:
              const TextStyle(color: whiteColor, fontStyle: FontStyle.italic),
          helperStyle: const TextStyle(color: whiteColor),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          hintText: hinttext,
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
}
