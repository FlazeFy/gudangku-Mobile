import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/model/queries.dart';
import 'package:gudangku/modules/api/inventory/service/queries.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/converter.dart';
import 'package:gudangku/views/detail_inventory/index.dart';
import 'package:gudangku/views/inventory/usecase/put_recover_inventory.dart';
import 'package:gudangku/views/inventory/usecase/put_favorite_toogle.dart';
import 'package:gudangku/views/inventory/usecase/get_inventory_props.dart';
import 'package:gudangku/views/inventory/usecase/hard_delete_inventory.dart';
import 'package:gudangku/views/inventory/usecase/soft_delete_inventory.dart';

class GetAllInventory extends StatefulWidget {
  const GetAllInventory({super.key, required this.viewType});
  final String viewType;

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
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    var data = await apiInventoryQuery.getAllInventory(pageMyInventory);
    setState(() {
      dt = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : _buildListView(dt),
    );
  }

  Widget _buildListView(List<InventoryAllModel> data) {
    Widget getDeleteButton(InventoryAllModel dt) {
      return dt.deletedAt == ""
          ? SoftDeleteInventory(
              id: dt.id,
              inventoryName: dt.inventoryName,
              onReload: loadData,
            )
          : HardDeleteInventory(
              id: dt.id,
              inventoryName: dt.inventoryName,
              onReload: loadData,
            );
    }

    Widget getPropsButton(InventoryAllModel dt) {
      return PropsInventory(
          createdAt: dt.createdAt,
          updatedAt: dt.updatedAt ?? "",
          deletedAt: dt.deletedAt ?? "");
    }

    Widget getFavoriteButton(InventoryAllModel dt) {
      return FavoriteToogle(
        id: dt.id,
        isFavorite: dt.isFavorite,
        onReload: loadData,
      );
    }

    Widget getEditRecoverButton(InventoryAllModel dt) {
      return dt.deletedAt != ""
          ? PostRecover(
              id: dt.id,
              inventoryName: dt.inventoryName,
              onReload: loadData,
            )
          : Container(
              margin: const EdgeInsets.all(spaceSM),
              child: InkWell(
                onTap: () {
                  Get.to(EditInventoryPage(id: dt.id));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: spaceSM),
                  decoration: BoxDecoration(
                      border: Border.all(color: warningBG, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(roundedMD))),
                  child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.penToSquare,
                          size: textLG,
                        )
                      ]),
                ),
              ));
    }

    if (data.isNotEmpty) {
      if (widget.viewType == 'table') {
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
                              child: Align(
                                  alignment: Alignment.center,
                                  child: ComponentText(
                                      type: 'table_text',
                                      text: dt.inventoryCategory)))),
                      TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(spaceXSM),
                              child: ComponentText(
                                  type: 'table_text',
                                  text: dt.inventoryDesc ?? '-'))),
                      TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(spaceXSM),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: ComponentText(
                                      type: 'table_text',
                                      text: dt.inventoryMerk ?? '-')))),
                      TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(spaceXSM),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: ComponentText(
                                      type: 'table_text',
                                      text: dt.inventoryRoom)))),
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
                              child: Align(
                                  alignment: Alignment.center,
                                  child: ComponentText(
                                      type: 'table_text',
                                      text:
                                          "${dt.inventoryVol} ${dt.inventoryUnit}")))),
                      TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(spaceXSM),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: ComponentText(
                                      type: 'table_text',
                                      text:
                                          "${dt.inventoryCapacityVol ?? "-"} ${dt.inventoryCapacityUnit == "percentage" ? "%" : "-"}")))),
                      TableCell(child: getPropsButton(dt)),
                      TableCell(child: getFavoriteButton(dt)),
                      TableCell(child: getEditRecoverButton(dt)),
                      TableCell(child: getDeleteButton(dt)),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        );
      } else {
        return Column(
          children: data.map<Widget>((dt) {
            return InkWell(
                onTap: () {
                  Get.to(EditInventoryPage(id: dt.id));
                },
                child: Container(
                  padding: const EdgeInsets.all(spaceMD),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: spaceMini / 2, color: primaryColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(roundedLG))),
                  margin: const EdgeInsets.only(bottom: spaceMD),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ComponentText(
                          type: 'content_title', text: dt.inventoryName),
                      Wrap(
                        children: [
                          ComponentButton(
                              type: 'button_tag', text: dt.inventoryCategory),
                          const SizedBox(width: spaceXXSM),
                          dt.inventoryMerk != null
                              ? ComponentButton(
                                  type: 'button_tag_secondary',
                                  text: dt.inventoryMerk ?? '-')
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: spaceMini),
                      const Divider(color: whiteColor),
                      const ComponentText(
                          type: 'content_sub_title', text: 'Description'),
                      dt.inventoryDesc != ''
                          ? ComponentText(
                              type: 'content_body',
                              text: dt.inventoryDesc ?? '-')
                          : const ComponentText(
                              type: 'no_data', text: 'No description provided'),
                      const SizedBox(height: spaceMD),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ComponentText(
                                  type: 'content_sub_title', text: 'Room'),
                              ComponentText(
                                  type: 'content_body', text: dt.inventoryRoom),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const ComponentText(
                                  type: 'content_sub_title',
                                  text: 'Storage / Rack'),
                              ComponentText(
                                  type: 'content_body',
                                  text:
                                      '${dt.inventoryStorage ?? '-'} / ${dt.inventoryRack ?? '-'}'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: spaceMini),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ComponentText(
                                  type: 'content_sub_title', text: 'Price'),
                              ComponentText(
                                  type: 'content_body',
                                  text:
                                      "Rp. ${numberFormat(dt.inventoryPrice)}"),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const ComponentText(
                                  type: 'content_sub_title', text: 'Unit'),
                              ComponentText(
                                  type: 'content_body',
                                  text:
                                      '${dt.inventoryVol} ${dt.inventoryUnit}'),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const ComponentText(
                                  type: 'content_sub_title', text: 'Capacity'),
                              ComponentText(
                                  type: 'content_body',
                                  text: dt.inventoryCapacityVol != 0
                                      ? '${dt.inventoryCapacityVol} ${dt.inventoryCapacityUnit}'
                                      : '-'),
                            ],
                          ),
                        ],
                      ),
                      const Divider(color: whiteColor),
                      Row(
                        children: [
                          SizedBox(
                              width: Get.width * 0.21,
                              child: getFavoriteButton(dt)),
                          const Spacer(),
                          SizedBox(
                              width: Get.width * 0.21,
                              child: getPropsButton(dt)),
                          const Spacer(),
                          SizedBox(
                              width: Get.width * 0.21,
                              child: getDeleteButton(dt)),
                          const Spacer(),
                          SizedBox(
                              width: Get.width * 0.21,
                              child: getEditRecoverButton(dt))
                        ],
                      )
                    ],
                  ),
                ));
          }).toList(),
        );
      }
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
