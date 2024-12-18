import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/dialog/rest_time_dialog.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/custom_doc/index.dart';
import 'package:gudangku/views/detail_inventory/usecases/get_detail_inventory.dart';

class EditInventoryPage extends StatefulWidget {
  const EditInventoryPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  StateEditInventoryPageState createState() => StateEditInventoryPageState();
}

class StateEditInventoryPageState extends State<EditInventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ComponentAppBar(
          title: 'Edit Inventory',
          isSubMenu: true,
          extraButton: [
            getRestTimeDialog('Dictionary', dctFetchRestTime),
            IconButton(
                onPressed: () {
                  Get.to(CustomDocPage(id: widget.id, type: "inventory"));
                },
                icon: const FaIcon(
                  FontAwesomeIcons.print,
                  color: whiteColor,
                ))
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: spaceMD),
          children: [
            const SizedBox(height: spaceMD),
            GetDetailInventory(id: widget.id),
            const FooterBar()
          ],
        ));
  }
}
