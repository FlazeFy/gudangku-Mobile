import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/model/commands.dart';
import 'package:gudangku/modules/api/inventory/service/commands.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/dialog/success_dialog.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/input/label.dart';
import 'package:gudangku/modules/component/others.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/add_inventory/usecases/preview_image.dart';
import 'package:gudangku/views/inventory/index.dart';
import 'package:gudangku/views/others/get_dct.dart';

class PostInventory extends StatefulWidget {
  const PostInventory({Key? key}) : super(key: key);

  @override
  StatePostInventoryState createState() => StatePostInventoryState();
}

class StatePostInventoryState extends State<PostInventory> {
  TextEditingController inventoryNameCtrl = TextEditingController();
  TextEditingController inventoryDescCtrl = TextEditingController();
  TextEditingController inventoryMerkCtrl = TextEditingController();
  TextEditingController inventoryPriceCtrl = TextEditingController();
  TextEditingController inventoryStorageCtrl = TextEditingController();
  TextEditingController inventoryRackCtrl = TextEditingController();
  TextEditingController inventoryVolCtrl = TextEditingController();
  TextEditingController inventoryCapVolCtrl = TextEditingController();
  String selectedInventoryUnit = '-';
  String selectedInventoryCat = '-';
  String selectedInventoryRoom = '-';
  String selectedInventoryUnitCap = '-';
  bool isFavorite = false;
  bool isLoadPost = false;
  String allMsg = "";
  late InventoryCommandsService apiCommand;

  @override
  void initState() {
    super.initState();
    apiCommand = InventoryCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ComponentText(type: 'content_title', text: 'Image'),
        const PreviewImage(),
        Container(
            margin: const EdgeInsets.symmetric(vertical: spaceMD),
            child: RichText(
                text: const TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(right: spaceMini),
                    child: FaIcon(FontAwesomeIcons.circleInfo,
                        color: whiteColor, size: textXMD),
                  ),
                ),
                TextSpan(
                  text:
                      "Maximum size of uploaded image is 10 mb and have file type JPG, PNG, or JPEG",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: textXMD,
                  ),
                ),
              ],
            ))),
        const SizedBox(height: spaceMD),
        const ComponentText(type: 'content_title', text: 'Inventory Detail'),
        getInputLabel("Name"),
        ComponentInput(
            ctrl: inventoryNameCtrl,
            hinttext: "ex : plate",
            maxLength: 75,
            type: 'text'),
        getInputLabel("Category"),
        GetAllDctByType(
            type: 'inventory_category',
            selected: selectedInventoryCat,
            action: (value) {
              setState(() {
                selectedInventoryCat = value;
              });
            }),
        getInputLabel("Description"),
        ComponentInput(
          ctrl: inventoryDescCtrl,
          hinttext: "ex : this plate is good and cheap",
          maxLength: 255,
          type: 'text',
          maxLines: 5,
        ),
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
        getDivider(),
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
                        type: 'inventory_unit',
                        selected: selectedInventoryUnit,
                        action: (value) {
                          setState(() {
                            selectedInventoryUnit = value;
                          });
                        })
                  ],
                ))
          ],
        ),
        getDivider(),
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
                        type: 'inventory_unit',
                        selected: selectedInventoryUnitCap,
                        action: (value) {
                          setState(() {
                            selectedInventoryUnitCap = value;
                          });
                        })
                  ],
                ))
          ],
        ),
        getDivider(),
        const ComponentText(type: 'content_title', text: 'Placement'),
        getInputLabel("Room"),
        GetAllDctByType(
            type: 'inventory_room',
            selected: selectedInventoryRoom,
            action: (value) {
              setState(() {
                selectedInventoryRoom = value;
              });
            }),
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
        ComponentInput(
            ctrl: isFavorite,
            type: 'checkbox',
            hinttext: 'Make this as Favorite Inventory',
            action: (bool? value) {
              setState(() {
                isFavorite = value!;
              });
            }),
        Container(
            margin: const EdgeInsets.symmetric(vertical: spaceMD),
            child: RichText(
                text: const TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(right: spaceMini),
                    child: FaIcon(FontAwesomeIcons.circleInfo,
                        color: whiteColor, size: textXMD),
                  ),
                ),
                TextSpan(
                  text:
                      "We have also sent a detailed inventory creation report to your registered contact information connected with our app",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: textXMD,
                  ),
                ),
              ],
            ))),
        Container(
            margin: const EdgeInsets.only(top: spaceMD, bottom: spaceJumbo),
            child: InkWell(
              child: const ComponentButton(
                type: 'button_success',
                text: 'Submit',
                icon: FaIcon(FontAwesomeIcons.floppyDisk,
                    color: whiteColor, size: textLG),
              ),
              onTap: () {
                if (isLoadPost == false) {
                  setState(() {
                    isLoadPost = true;
                  });
                  bool isValid = true;

                  if (inventoryPriceCtrl.text.isEmpty) {
                    isValid = false;
                    allMsg += 'the price cant be empty,';
                  } else if (inventoryPriceCtrl.text[0] == '0') {
                    isValid = false;
                    allMsg += 'the price cant start with zero,';
                  }
                  if (inventoryVolCtrl.text.isEmpty) {
                    isValid = false;
                    allMsg += 'the volume cant be empty,';
                  } else if (inventoryVolCtrl.text[0] == '0') {
                    isValid = false;
                    allMsg += 'the volume cant start with zero,';
                  }
                  if (selectedInventoryCat == '-') {
                    isValid = false;
                    allMsg += 'the category cant be empty,';
                  }
                  if (selectedInventoryUnit == '-') {
                    isValid = false;
                    allMsg += 'the unit cant be empty,';
                  }
                  if (selectedInventoryRoom == '-') {
                    isValid = false;
                    allMsg += 'the room cant be empty,';
                  }
                  if (selectedInventoryUnitCap != '-' &&
                      inventoryCapVolCtrl.text.isEmpty) {
                    isValid = false;
                    allMsg +=
                        'the volume capacity cant be empty if you have select the unit capacity,';
                  } else if (selectedInventoryUnitCap != '-' &&
                      inventoryCapVolCtrl.text.isNotEmpty &&
                      inventoryCapVolCtrl.text[0] == '0') {
                    isValid = false;
                    allMsg += 'the volume capacity cant start with zero,';
                  }

                  if (isValid) {
                    InventoryModel data = InventoryModel(
                        inventoryName: inventoryNameCtrl.text.trim(),
                        inventoryCategory: selectedInventoryCat,
                        inventoryDesc: inventoryDescCtrl.text.trim(),
                        inventoryMerk: inventoryMerkCtrl.text.trim(),
                        inventoryRoom: selectedInventoryRoom,
                        inventoryStorage: inventoryStorageCtrl.text.trim(),
                        inventoryRack: inventoryRackCtrl.text.trim(),
                        inventoryPrice:
                            int.parse(inventoryPriceCtrl.text.trim()),
                        inventoryImage: null,
                        inventoryUnit: selectedInventoryUnit,
                        inventoryVol: int.parse(inventoryVolCtrl.text.trim()),
                        inventoryCapacityUnit: selectedInventoryUnitCap != '-'
                            ? selectedInventoryUnitCap
                            : null,
                        inventoryCapacityVol:
                            inventoryCapVolCtrl.text.isNotEmpty
                                ? int.parse(inventoryCapVolCtrl.text.trim())
                                : null,
                        inventoryColor: null,
                        isFavorite: isFavorite ? 1 : 0,
                        isReminder: 0);
                    apiCommand.postInventory(data).then((response) {
                      setState(() => {});
                      var status = response[0]['status'];
                      var msg = response[0]['message'];

                      if (status == "success") {
                        Get.to(const InventoryPage());

                        Get.dialog(SuccessDialog(text: msg));
                      } else {
                        if (msg is! String) {
                        } else {
                          allMsg = msg;
                        }
                        Get.dialog(
                            FailedDialog(text: allMsg, type: "addevent"));
                      }
                    });
                  } else {
                    Get.dialog(FailedDialog(text: allMsg, type: null));
                  }

                  setState(() {
                    allMsg = "";
                    isLoadPost = false;
                  });
                }
              },
            )),
      ],
    );
  }
}
