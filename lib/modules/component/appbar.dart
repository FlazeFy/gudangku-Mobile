import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';

class ComponentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isSubMenu;

  const ComponentAppBar(
      {super.key, required this.title, required this.isSubMenu});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: darkColor,
      automaticallyImplyLeading: false,
      title: ComponentText(type: 'appbar_text', text: title),
      actions: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.bell),
          tooltip: 'Notification',
          onPressed: () {},
          color: whiteColor,
        ),
        isSubMenu
            ? IconButton(
                icon: const Icon(Icons.home),
                tooltip: 'Back',
                onPressed: () {
                  Get.back();
                },
                color: whiteColor,
              )
            : const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
