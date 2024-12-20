import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/notification/index.dart';

class ComponentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isSubMenu;
  final List<Widget>? extraButton;

  const ComponentAppBar(
      {super.key,
      required this.title,
      required this.isSubMenu,
      this.extraButton});

  @override
  Widget build(BuildContext context) {
    List<Widget> action = [
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.bell),
        tooltip: 'Notification',
        onPressed: () {
          Get.to(const NotificationPage());
        },
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
    ];
    if (extraButton != null && extraButton!.isNotEmpty) {
      action.insertAll(0, extraButton!);
    }

    return AppBar(
      backgroundColor: darkColor,
      automaticallyImplyLeading: false,
      title: ComponentText(type: 'appbar_text', text: title),
      actions: action,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
