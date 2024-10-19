import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/dialog/rest_time_dialog.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/add_inventory/usecases/post_inventory.dart';

class AddInventoryPage extends StatefulWidget {
  const AddInventoryPage({Key? key}) : super(key: key);

  @override
  StateAddInventoryPageState createState() => StateAddInventoryPageState();
}

class StateAddInventoryPageState extends State<AddInventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ComponentAppBar(
          title: 'Add Inventory',
          isSubMenu: true,
          extraButton: [getRestTimeDialog('Dictionary', dctFetchRestTime)],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: spaceMD),
          children: const [PostInventory()],
        ));
  }
}
