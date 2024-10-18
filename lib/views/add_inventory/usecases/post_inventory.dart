import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/input/label.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/views/others/get_dct.dart';

class PostInventory extends StatefulWidget {
  const PostInventory({Key? key}) : super(key: key);

  @override
  StatePostInventoryState createState() => StatePostInventoryState();
}

class StatePostInventoryState extends State<PostInventory> {
  TextEditingController inventoryNameCtrl = TextEditingController();
  TextEditingController inventoryMerkCtrl = TextEditingController();
  TextEditingController inventoryPriceCtrl = TextEditingController();
  TextEditingController inventoryStorageCtrl = TextEditingController();
  TextEditingController inventoryRackCtrl = TextEditingController();
  TextEditingController inventoryVolCtrl = TextEditingController();
  TextEditingController inventoryCapVolCtrl = TextEditingController();
  String selectedInventoryUnit = '-';
  String selectedInventoryRoom = '-';
  String selectedInventoryUnitRemain = '-';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ComponentText(type: 'content_title', text: 'Inventory Detail'),
        getInputLabel("Name"),
        ComponentInput(
            ctrl: inventoryNameCtrl,
            hinttext: "ex : plate",
            maxLength: 75,
            type: 'text'),
        getInputLabel("Merk"),
        ComponentInput(
            ctrl: inventoryMerkCtrl,
            hinttext: "ex : awesome plate",
            maxLength: 75,
            type: 'text'),
        getInputLabel("Price"),
        ComponentInput(
            ctrl: inventoryPriceCtrl,
            hinttext: "0",
            maxLength: 9,
            type: 'number'),
        const ComponentText(type: 'content_title', text: 'Standard Capacity'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInputLabel("Volume"),
                    ComponentInput(
                        ctrl: inventoryVolCtrl,
                        hinttext: "0",
                        maxLength: 6,
                        type: 'number'),
                  ],
                )),
            const Spacer(),
            SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInputLabel("Unit"),
                    GetAllDctByType(
                        type: 'inventory_unit', selected: selectedInventoryUnit)
                  ],
                ))
          ],
        ),
        const ComponentText(type: 'content_title', text: 'Remaining Capacity'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInputLabel("Volume"),
                    ComponentInput(
                        ctrl: inventoryCapVolCtrl,
                        hinttext: "0",
                        maxLength: 6,
                        type: 'number'),
                  ],
                )),
            const Spacer(),
            SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInputLabel("Unit"),
                    GetAllDctByType(
                        type: 'inventory_unit', selected: selectedInventoryUnit)
                  ],
                ))
          ],
        ),
        const ComponentText(type: 'content_title', text: 'Placement'),
        getInputLabel("Room"),
        GetAllDctByType(
            type: 'inventory_unit', selected: selectedInventoryUnit),
        getInputLabel("Storage"),
        ComponentInput(
            ctrl: inventoryStorageCtrl,
            hinttext: "ex : wardobe",
            maxLength: 36,
            secure: false,
            type: 'text'),
        getInputLabel("Rack"),
        ComponentInput(
            ctrl: inventoryRackCtrl,
            hinttext: "ex : shelf A",
            maxLength: 36,
            secure: false,
            type: 'text'),
      ],
    );
  }
}
