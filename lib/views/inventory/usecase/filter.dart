import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/dictionary/model/queries.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/input/label.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/others/get_dct.dart';

class FilterInventory extends StatefulWidget {
  const FilterInventory({Key? key}) : super(key: key);

  @override
  StateFilterInventory createState() => StateFilterInventory();
}

class StateFilterInventory extends State<FilterInventory> {
  TextEditingController inventoryNameCtrl = TextEditingController();
  String selectedFilterByCat = "All";
  String selectedSorting = "Descending By Created At";

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: whiteColor),
            borderRadius: const BorderRadius.all(Radius.circular(roundedMD))),
        child: ExpansionTile(
          childrenPadding: const EdgeInsets.symmetric(horizontal: spaceMD),
          initiallyExpanded: true,
          title: const ComponentText(
            text: "Control Panel",
            type: 'content_sub_title',
          ),
          subtitle: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                    text: "Showing",
                    style: TextStyle(
                        color: whiteColor, fontWeight: FontWeight.bold)),
                TextSpan(
                  text: " 22 Items",
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: textJumbo),
                ),
              ],
            ),
          ),
          children: <Widget>[
            getInputLabel("Search by Name or Merk"),
            ComponentInput(
                ctrl: inventoryNameCtrl,
                hinttext: "ex : plate",
                maxLength: 75,
                type: 'text'),
            getInputLabel("Search by Category"),
            GetAllDctByType(
                type: 'inventory_category',
                selected: selectedFilterByCat,
                dct: [
                  DctModel(dctName: 'All'),
                  DctModel(dctName: 'Deleted'),
                  DctModel(dctName: 'Favorite'),
                  DctModel(dctName: 'Reminder')
                ],
                action: (value) {
                  setState(() {
                    selectedFilterByCat = value;
                  });
                }),
            getInputLabel("Sorting"),
            GetAllDctByType(
                selected: selectedSorting,
                dct: [
                  DctModel(dctName: 'Descending By Name'),
                  DctModel(dctName: 'Ascending By Name'),
                  DctModel(dctName: 'Descending By Price'),
                  DctModel(dctName: 'Ascending By Price'),
                  DctModel(dctName: 'Descending By Created At'),
                  DctModel(dctName: 'Ascending By Created At'),
                  DctModel(dctName: 'Descending By Updated At'),
                  DctModel(dctName: 'Ascending By Updated At'),
                ],
                action: (value) {
                  setState(() {
                    selectedSorting = value;
                  });
                }),
          ],
        ));
  }
}
