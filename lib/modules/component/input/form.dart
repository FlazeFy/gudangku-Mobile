import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/style.dart';

class ComponentInput extends StatelessWidget {
  final dynamic ctrl;
  final String type;
  final String? hinttext;
  final bool? secure;
  final int? maxLength;
  final int? minLength;
  final dynamic action;
  final int? maxLines;

  const ComponentInput(
      {super.key,
      required this.ctrl,
      required this.type,
      this.hinttext,
      this.secure,
      this.maxLength,
      this.minLength,
      this.action,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    if (type != 'checkbox') {
      return Container(
        padding: EdgeInsets.zero,
        child: TextFormField(
          obscureText: secure ?? false,
          cursorColor: whiteColor,
          controller: ctrl,
          maxLines: maxLines ?? 1,
          keyboardType:
              type == 'number' ? TextInputType.number : TextInputType.text,
          maxLength: maxLength ?? 255,
          style: const TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.w400,
              fontSize: textXMD),
          decoration: InputDecoration(
            hintStyle:
                const TextStyle(color: whiteColor, fontStyle: FontStyle.italic),
            helperStyle: const TextStyle(color: whiteColor),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            hintText: hinttext,
          ),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            checkColor: successBG,
            fillColor: MaterialStateProperty.all(Colors.transparent),
            value: ctrl,
            side: const BorderSide(color: primaryColor),
            activeColor: primaryColor,
            onChanged: action,
          ),
          hinttext != null
              ? Text(
                  hinttext ?? '',
                  style: const TextStyle(color: whiteColor, fontSize: textMD),
                )
              : const SizedBox(),
        ],
      );
    }
  }
}
