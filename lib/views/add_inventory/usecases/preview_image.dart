import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
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
                padding: const EdgeInsets.all(spaceLG),
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(roundedMD)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(FontAwesomeIcons.image,
                        color: greyColor, size: textJumbo),
                    const ComponentText(
                        type: 'no_data', text: 'no image has been selected'),
                    const SizedBox(height: spaceMD),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(const CameraInventory());
                          },
                          child: const ComponentButton(
                            type: 'button_primary',
                            text: 'Capture Image',
                            icon: FaIcon(FontAwesomeIcons.camera,
                                color: whiteColor, size: textLG),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: const ComponentButton(
                            type: 'button_primary',
                            text: 'File Picker',
                            icon: FaIcon(FontAwesomeIcons.folder,
                                color: whiteColor, size: textLG),
                          ),
                        )
                      ],
                    )
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
