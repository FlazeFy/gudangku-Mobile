import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/dictionary/model/queries.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/input/label.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/others/get_dct.dart';

class FilterReport extends StatefulWidget {
  const FilterReport({Key? key}) : super(key: key);

  @override
  StateFilterReport createState() => StateFilterReport();
}

class StateFilterReport extends State<FilterReport> {
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
            getInputLabel("Search by Title"),
            ComponentInput(
                ctrl: inventoryNameCtrl,
                hinttext: "ex : plate",
                maxLength: 75,
                type: 'text'),
            getInputLabel("Search by Category"),
            GetAllDctByType(
                selected: selectedFilterByCat,
                dct: [
                  DctModel(dctName: 'All'),
                ],
                action: (value) {
                  setState(() {
                    selectedFilterByCat = value;
                  });
                }),
            getInputLabel("Sorting"),
            GetAllDctByType(
                type: 'report_category',
                selected: selectedSorting,
                dct: [
                  DctModel(dctName: 'Descending By Title'),
                  DctModel(dctName: 'Ascending By Title'),
                  DctModel(dctName: 'Descending By Created At'),
                  DctModel(dctName: 'Ascending By Created At'),
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
