import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/inventory/model/queries.dart';
import 'package:gudangku/modules/api/inventory/service/queries.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/inventory/usecase/put_recover_inventory.dart';
import 'package:gudangku/views/inventory/usecase/put_favorite_toogle.dart';
import 'package:gudangku/views/inventory/usecase/get_inventory_props.dart';
import 'package:gudangku/views/inventory/usecase/hard_delete_inventory.dart';
import 'package:gudangku/views/inventory/usecase/soft_delete_inventory.dart';

class GetAllInventory extends StatefulWidget {
  const GetAllInventory({super.key});

  @override
  StateGetAllInventory createState() => StateGetAllInventory();
}

class StateGetAllInventory extends State<GetAllInventory> {
  late InventoryQueriesService apiInventoryQuery;
  int i = 0;
  List<InventoryAllModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    apiInventoryQuery = InventoryQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiInventoryQuery.getAllInventory(pageMyInventory),
        builder: (BuildContext context,
            AsyncSnapshot<List<InventoryAllModel>> snapshot) {
          if (snapshot.hasError) {
            // Get.dialog(FailedDialog(
            //     text: "Unknown error, please contact the admin",
            //     type: "error"));
            return Center(
              child: Text(snapshot.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<InventoryAllModel> contents = snapshot.data ?? [];
            return _buildListView(contents);
          } else {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<InventoryAllModel> data) {
    if (data.isNotEmpty) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1400,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(
                borderRadius:
                    const BorderRadius.all(Radius.circular(roundedMini)),
                color: primaryColor),
            columnWidths: const {
              0: FixedColumnWidth(140),
              1: FixedColumnWidth(100),
              2: FixedColumnWidth(160),
              3: FixedColumnWidth(100),
              4: FixedColumnWidth(100),
              5: FixedColumnWidth(140),
              6: FixedColumnWidth(120),
              7: FixedColumnWidth(80),
              8: FixedColumnWidth(100),
              9: FixedColumnWidth(80),
              10: FixedColumnWidth(80),
              11: FixedColumnWidth(80),
              12: FixedColumnWidth(80),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                      child: Container(
                    color: primaryColor,
                    padding: const EdgeInsets.all(spaceMD),
                    child: const Text(
                      'Name',
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
                      'Category',
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
                      'Merk',
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
                          'Room',
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
                          'Storage / Rack',
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
                          'Volume',
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
                          'Capacity',
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
                          'Info',
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
                          'Favorite',
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
              ...data.map<TableRow>((dt) {
                return TableRow(
                  children: [
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(spaceXSM),
                            child: ComponentText(
                                type: 'table_text', text: dt.inventoryName))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(spaceXSM),
                            child: ComponentText(
                                type: 'table_text',
                                text: dt.inventoryCategory))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(spaceXSM),
                            child: ComponentText(
                                type: 'table_text',
                                text: dt.inventoryDesc ?? '-'))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(spaceXSM),
                            child: ComponentText(
                                type: 'table_text', text: dt.inventoryMerk))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(spaceXSM),
                            child: ComponentText(
                                type: 'table_text', text: dt.inventoryRoom))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(spaceXSM),
                            child: ComponentText(
                                type: 'table_text',
                                text:
                                    "${dt.inventoryStorage ?? "-"} / ${dt.inventoryRack ?? "-"}"))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(spaceXSM),
                            child: ComponentText(
                                type: 'table_text',
                                text: "Rp. ${dt.inventoryPrice}"))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(spaceXSM),
                            child: ComponentText(
                                type: 'table_text',
                                text:
                                    "${dt.inventoryVol} ${dt.inventoryUnit}"))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(spaceXSM),
                            child: ComponentText(
                                type: 'table_text',
                                text:
                                    "${dt.inventoryCapacityVol ?? "-"} ${dt.inventoryCapacityUnit == "percentage" ? "%" : "-"}"))),
                    TableCell(
                        child: PropsInventory(
                            createdAt: dt.createdAt,
                            updatedAt: dt.updatedAt ?? "",
                            deletedAt: dt.deletedAt ?? "")),
                    TableCell(
                        child: FavoriteToogle(
                      id: dt.id,
                      isFavorite: dt.isFavorite,
                    )),
                    TableCell(
                        child: dt.deletedAt != ""
                            ? PostRecover(
                                id: dt.id,
                                inventoryName: dt.inventoryName,
                              )
                            : const SizedBox()),
                    TableCell(
                        child: dt.deletedAt == ""
                            ? SoftDeleteInventory(
                                id: dt.id,
                                inventoryName: dt.inventoryName,
                              )
                            : HardDeleteInventory(
                                id: dt.id,
                                inventoryName: dt.inventoryName,
                              )),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
