import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';

class DataConstraint extends StatefulWidget {
  const DataConstraint({super.key});

  @override
  StateDataConstraint createState() => StateDataConstraint();
}

class StateDataConstraint extends State<DataConstraint> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ComponentText(type: "content_title", text: "Data Constraint"),
        Container(
          margin: const EdgeInsets.only(bottom: spaceMD),
          width: Get.width,
          decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: whiteColor),
              borderRadius: const BorderRadius.all(Radius.circular(roundedMD))),
          padding: const EdgeInsets.all(spaceMD),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ComponentText(type: "content_title", text: "Inventory"),
              ComponentText(
                  type: "content_body",
                  text: "- Inventory Name (Max Char: 75)"),
              ComponentText(
                  type: "content_body",
                  text:
                      "- Inventory Category (Such as : Food And Beverages, Office Tools, and Skin & Body Care)"),
              ComponentText(
                  type: "content_body",
                  text: "- Inventory Description (Max Char: 255, Optional)"),
              ComponentText(
                  type: "content_body",
                  text: "- Inventory Merk (Max Char: 75, Optional)"),
              ComponentText(
                  type: "content_body",
                  text:
                      "- Inventory Room (Such as : Bathroom, Car Cabin, Main Room, and Terrace)"),
              ComponentText(
                  type: "content_body",
                  text: "- Inventory Storage (Max Char: 36, Optional)"),
              ComponentText(
                  type: "content_body",
                  text: "- Inventory Rack (Max Char: 36, Optional)"),
              ComponentText(
                  type: "content_body",
                  text: "- Inventory Price (Max Char: 9)"),
              ComponentText(
                  type: "content_body",
                  text:
                      "- Inventory Image (Allowed Type : JPG, JPEG, PNG, GIF, Max Size : 10 Mb, Optional)"),
              ComponentText(
                  type: "content_body",
                  text:
                      "- Inventory Color (From Uploaded Images, or Manually Input)"),
              ComponentText(
                  type: "content_body",
                  text:
                      "- Inventory Unit, Inventory Capacity Unit (Such as : Kilogram, Liter, Ml, and Pcs)"),
              ComponentText(
                  type: "content_body",
                  text:
                      "- Inventory Volume, Inventory Capacity Volume (Max Char: 6)"),
              ComponentText(
                  type: "content_body",
                  text:
                      "- Is Inventory Reminded At, Is Favorited (True / False)")
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: spaceMD),
          width: Get.width,
          decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: whiteColor),
              borderRadius: const BorderRadius.all(Radius.circular(roundedMD))),
          padding: const EdgeInsets.all(spaceMD),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ComponentText(type: "content_title", text: "Reminder"),
              ComponentText(
                  type: "content_body",
                  text: "- Reminder Description (Max Char: 255)"),
              ComponentText(
                  type: "content_body",
                  text:
                      "- Reminder Type (Such as : Every Month, and Every Week)"),
              ComponentText(
                  type: "content_body",
                  text: "- Reminder Context (Such as : Every Day 1)"),
              ComponentText(type: "content_body", text: "- Remind At (Date)"),
              ComponentText(
                  type: "content_body",
                  text: "- Is Report Reminded At (True / False)"),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: spaceMD),
          width: Get.width,
          decoration: BoxDecoration(
              border: Border.all(width: 1.5, color: whiteColor),
              borderRadius: const BorderRadius.all(Radius.circular(roundedMD))),
          padding: const EdgeInsets.all(spaceMD),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ComponentText(type: "content_title", text: "Report"),
              ComponentText(
                  type: "content_body", text: "- Report Title (Max Char: 75)"),
              ComponentText(
                  type: "content_body",
                  text:
                      "- Report Category (Such as : Checklist, Checkout, Others, Shopping Cart, Wash List, and Wishlist)"),
              ComponentText(
                  type: "content_body",
                  text: "- Report Description (Max Char: 255, Optional)"),
              ComponentText(
                  type: "content_body",
                  text:
                      "- Report Image (Allowed Type : JPG, JPEG, PNG, GIF, Max Size : 10 Mb, Optional))"),
              ComponentText(type: "content_body", text: "- Remind At (Date)"),
              ComponentText(
                  type: "content_body",
                  text: "- Is Report Reminded At (True / False)"),
            ],
          ),
        )
      ],
    );
  }
}
