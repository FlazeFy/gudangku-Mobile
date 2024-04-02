import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/model/queries.dart';
import 'package:gudangku/modules/api/inventory/service/queries.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/inventory/usecase/soft_delete_inventory.dart';

class GetAllInventory extends StatefulWidget {
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
        future: apiInventoryQuery.getAllInventory(),
        builder: (BuildContext context,
            AsyncSnapshot<List<InventoryAllModel>> snapshot) {
          if (snapshot.hasError) {
            // Get.dialog(FailedDialog(
            //     text: "Unknown error, please contact the admin",
            //     type: "error"));
            return const Center(
              child: Text("Something wrong"),
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
            width: Get.width * 3,
            child: DataTable(
              columnSpacing: spaceSM,
              horizontalMargin: spaceLG,
              columns: const [
                DataColumn(label: Text('Inventory Name')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Merk')),
                DataColumn(label: Text('Room')),
                DataColumn(label: Text('Storage / Rack')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Volume')),
                DataColumn(label: Text('Capacity')),
                DataColumn(label: Text('Delete'))
              ],
              rows: data.map<DataRow>((dt) {
                return DataRow(
                  color: dt.deletedAt == ""
                      ? MaterialStateProperty.all(Colors.transparent)
                      : MaterialStateProperty.all(dangerBG.withOpacity(0.25)),
                  cells: [
                    DataCell(Text(dt.inventoryName)),
                    DataCell(Text(dt.inventoryCategory)),
                    DataCell(Text(dt.inventoryDesc ?? "-")),
                    DataCell(Text(dt.inventoryMerk ?? "-")),
                    DataCell(Text(dt.inventoryRoom ?? "-")),
                    DataCell(Text(
                        "${dt.inventoryStorage ?? "-"} / ${dt.inventoryRack ?? "-"}")),
                    DataCell(Text("Rp. ${dt.inventoryPrice}")),
                    DataCell(Text("${dt.inventoryVol} ${dt.inventoryUnit}")),
                    DataCell(Text(
                        "${dt.inventoryCapacityVol ?? "-"} ${dt.inventoryCapacityUnit == "percentage" ? "%" : "-"}")),
                    DataCell(SoftDeleteInventory(
                      id: dt.id,
                      inventoryName: dt.inventoryName,
                    ))
                  ],
                );
              }).toList(),
            ),
          ));
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
