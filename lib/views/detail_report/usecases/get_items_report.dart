import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/report/model/queries.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';

class GetItemsReport extends StatefulWidget {
  const GetItemsReport({super.key, required this.data});
  final List<InventoryReportModel> data;

  @override
  StateGetItemsReport createState() => StateGetItemsReport();
}

class StateGetItemsReport extends State<GetItemsReport> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 1000,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(
              borderRadius:
                  const BorderRadius.all(Radius.circular(roundedMini)),
              color: primaryColor),
          columnWidths: const {
            0: FixedColumnWidth(0),
            1: FixedColumnWidth(120),
            2: FixedColumnWidth(140),
            3: FixedColumnWidth(20),
            4: FixedColumnWidth(80),
            5: FixedColumnWidth(80),
            6: FixedColumnWidth(80),
            7: FixedColumnWidth(80),
          },
          children: [
            TableRow(
              children: [
                TableCell(
                    child: Container(
                  color: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: spaceMD),
                  child: const Text(
                    '#',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: whiteColor),
                    textAlign: TextAlign.center,
                  ),
                )),
                TableCell(
                    child: Container(
                  color: primaryColor,
                  padding: const EdgeInsets.all(spaceMD),
                  child: const Text(
                    'Item Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: whiteColor),
                    textAlign: TextAlign.center,
                  ),
                )),
                TableCell(
                    child: Container(
                  color: primaryColor,
                  padding: const EdgeInsets.all(spaceMD),
                  child: const Text(
                    'Description',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: whiteColor),
                    textAlign: TextAlign.center,
                  ),
                )),
                TableCell(
                    child: Container(
                  color: primaryColor,
                  padding: const EdgeInsets.all(spaceMD),
                  child: const Text(
                    'Qty',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: whiteColor),
                    textAlign: TextAlign.center,
                  ),
                )),
                TableCell(
                  child: Container(
                      color: primaryColor,
                      padding: const EdgeInsets.all(spaceMD),
                      child: const Text(
                        'Price',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: whiteColor),
                        textAlign: TextAlign.center,
                      )),
                ),
                TableCell(
                  child: Container(
                      color: primaryColor,
                      padding: const EdgeInsets.all(spaceMD),
                      child: const Text(
                        'Created At',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: whiteColor),
                        textAlign: TextAlign.center,
                      )),
                ),
                TableCell(
                  child: Container(
                      color: primaryColor,
                      padding: const EdgeInsets.all(spaceMD),
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: whiteColor),
                        textAlign: TextAlign.center,
                      )),
                ),
                TableCell(
                  child: Container(
                      color: primaryColor,
                      padding: const EdgeInsets.all(spaceMD),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: whiteColor),
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
            ),
            ...widget.data.map<TableRow>((dt) {
              return TableRow(
                children: [
                  TableCell(
                      child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: spaceXSM),
                          child:
                              ComponentInput(ctrl: isCheck, type: 'checkbox'))),
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(spaceXSM),
                          child: ComponentText(
                              type: 'table_text', text: dt.itemName))),
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(spaceXSM),
                          child: dt.itemDesc != ''
                              ? ComponentText(
                                  type: 'table_text', text: dt.itemDesc ?? '-')
                              : const ComponentText(
                                  text: 'No description provided',
                                  type: 'no_data',
                                ))),
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(spaceXSM),
                          child: Align(
                              alignment: Alignment.center,
                              child: ComponentText(
                                type: 'table_text',
                                text: dt.itemQty.toString(),
                              )))),
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(spaceXSM),
                          child: ComponentText(
                            type: 'table_text',
                            text: "Rp. ${dt.itemPrice},00",
                          ))),
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(spaceXSM),
                          child: ComponentText(
                              type: 'table_text', text: dt.createdAt))),
                  const TableCell(child: SizedBox()),
                  const TableCell(child: SizedBox()),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
