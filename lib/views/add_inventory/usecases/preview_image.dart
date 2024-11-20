import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/add_inventory/usecases/camera_inventory.dart';

class PreviewImage extends StatefulWidget {
  const PreviewImage({super.key});

  @override
  State<PreviewImage> createState() => StatePreviewImageState();
}

class StatePreviewImageState extends State<PreviewImage> {
  Future<XFile?> getImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  getImageAction(bool isSet) {
    return Container(
        padding: const EdgeInsets.only(top: spaceSM),
        child: !isSet
            ? Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(const CameraInventory());
                    },
                    child: const ComponentButton(
                      type: 'button_primary',
                      text: 'Capture',
                      icon: FaIcon(FontAwesomeIcons.camera,
                          color: whiteColor, size: textLG),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      var file = await getImage();

                      if (file != null) {
                        setState(() {
                          capturedImage = file;
                        });
                      }
                    },
                    child: const ComponentButton(
                      type: 'button_primary',
                      text: 'File Picker',
                      icon: FaIcon(FontAwesomeIcons.folder,
                          color: whiteColor, size: textLG),
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        capturedImage = null;
                      });
                    },
                    child: const ComponentButton(
                      type: 'button_danger',
                      text: 'Reset',
                      icon: FaIcon(FontAwesomeIcons.rotateLeft,
                          color: whiteColor, size: textLG),
                    ),
                  ),
                ],
              ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        child: SizedBox(
            width: Get.width,
            height: Get.width / 1.75,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(roundedMD),
              dashPattern: const [8, 4],
              color: primaryColor,
              strokeWidth: 1,
              child: Container(
                padding:
                    EdgeInsets.all(capturedImage == null ? spaceLG : spaceXSM),
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(roundedMD)),
                ),
                child: capturedImage == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.image,
                              color: greyColor, size: textJumbo),
                          const ComponentText(
                              type: 'no_data',
                              text: 'no image has been selected'),
                          getImageAction(false)
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(roundedMD),
                              child: Image.file(
                                File(capturedImage!
                                    .path), // Display the captured image
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          getImageAction(true)
                        ],
                      ),
              ),
            )),
        onTap: () {
          // zoom uploaded image
        },
      )
    ]);
  }
}
