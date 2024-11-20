import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/inventory/model/queries.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/input/label.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/others/get_dct.dart';

class GetReminder extends StatefulWidget {
  const GetReminder({super.key, required this.data});
  final ReminderModel data;

  @override
  StateGetReminder createState() => StateGetReminder();
}

class StateGetReminder extends State<GetReminder> {
  TextEditingController reminderDescCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    reminderDescCtrl.text = widget.data.reminderDesc;

    return Container(
        margin: const EdgeInsets.only(bottom: spaceMD),
        padding: const EdgeInsets.only(bottom: spaceXXSM),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 1),
          borderRadius: BorderRadius.circular(roundedLG),
        ),
        child: ExpansionTile(
          expandedAlignment: Alignment.topLeft,
          childrenPadding: const EdgeInsets.symmetric(horizontal: spaceMD),
          textColor: whiteColor,
          collapsedTextColor: whiteColor,
          title: ComponentText(
              type: 'content_title', text: widget.data.reminderDesc),
          subtitle: Wrap(children: [
            ComponentButton(
                type: 'button_tag',
                text:
                    "${widget.data.reminderType} at ${widget.data.reminderContext}")
          ]),
          children: <Widget>[
            const SizedBox(height: spaceXSM),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComponentText(
                        type: 'content_body',
                        color: greyColor,
                        fstyle: FontStyle.italic,
                        text: "Created At : ${widget.data.createdAt}"),
                    ComponentText(
                        type: 'content_body',
                        color: greyColor,
                        fstyle: FontStyle.italic,
                        text: "Last Updated : ${widget.data.updatedAt ?? '-'}")
                  ],
                )
              ],
            ),
            const SizedBox(height: spaceLG),
            getInputLabel("Type"),
            GetAllDctByType(
                type: 'reminder_type',
                selected: widget.data.reminderType,
                action: (value) {
                  setState(() {});
                }),
            getInputLabel("Category"),
            GetAllDctByType(
                type: 'reminder_context',
                selected: widget.data.reminderContext,
                action: (value) {
                  setState(() {});
                }),
            getInputLabel("Description"),
            ComponentInput(
              ctrl: reminderDescCtrl,
              hinttext: "ex : this plate is good and cheap",
              maxLength: 255,
              type: 'text',
              maxLines: 5,
            ),
          ],
        ));
  }
}
