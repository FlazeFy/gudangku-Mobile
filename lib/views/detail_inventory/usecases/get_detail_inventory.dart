import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/model/commands.dart';
import 'package:gudangku/modules/api/inventory/model/queries.dart';
import 'package:gudangku/modules/api/inventory/service/queries.dart';
import 'package:gudangku/modules/api/report/model/queries.dart';
import 'package:gudangku/modules/component/input/form.dart';
import 'package:gudangku/modules/component/input/label.dart';
import 'package:gudangku/modules/component/others.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/detail_inventory/usecases/get_reminder.dart';
import 'package:gudangku/views/detail_inventory/usecases/get_report_by_inventory.dart';
import 'package:gudangku/views/detail_inventory/usecases/post_reminder.dart';
import 'package:gudangku/views/others/get_dct.dart';

class GetDetailInventory extends StatefulWidget {
  const GetDetailInventory({super.key, required this.id});
  final String id;

  @override
  StateGetDetailInventory createState() => StateGetDetailInventory();
}

class StateGetDetailInventory extends State<GetDetailInventory> {
  TextEditingController inventoryNameCtrl = TextEditingController();
  TextEditingController inventoryDescCtrl = TextEditingController();
  TextEditingController inventoryMerkCtrl = TextEditingController();
  TextEditingController inventoryPriceCtrl = TextEditingController();
  TextEditingController inventoryStorageCtrl = TextEditingController();
  TextEditingController inventoryRackCtrl = TextEditingController();
  TextEditingController inventoryVolCtrl = TextEditingController();
  TextEditingController inventoryCapVolCtrl = TextEditingController();
  String selectedInventoryUnit = '-';
  String selectedInventoryCat = '-';
  String selectedInventoryRoom = '-';
  String selectedInventoryUnitCap = '-';
  bool isFavorite = false;
  bool isLoadPost = false;
  String allMsg = "";
  late InventoryQueriesService apiInventoryQuery;
  int i = 0;
  late InventoryModel detail;
  late List<ReminderModel>? reminder;
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
    var data = await apiInventoryQuery.getDetailInventory(widget.id);
    setState(() {
      if (data != null) {
        detail = data['detail'];
        reminder = data['reminder'];
      } else {
        detail = InventoryModel(
          inventoryName: '',
          inventoryCategory: '',
          inventoryMerk: '',
          inventoryRoom: '',
          inventoryPrice: 0,
          inventoryUnit: '',
          inventoryVol: 0,
          isFavorite: 0,
          isReminder: 0,
        );
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : _buildListView(detail, reminder),
    );
  }

  Widget _buildListView(InventoryModel detail, List<ReminderModel>? reminder) {
    inventoryNameCtrl.text = detail.inventoryName;
    inventoryDescCtrl.text = detail.inventoryDesc ?? '';
    inventoryMerkCtrl.text = detail.inventoryMerk ?? '';
    inventoryPriceCtrl.text = detail.inventoryPrice.toString();
    inventoryStorageCtrl.text = detail.inventoryStorage ?? '';
    inventoryRackCtrl.text = detail.inventoryRack ?? '';
    inventoryVolCtrl.text = detail.inventoryVol.toString();
    inventoryCapVolCtrl.text = detail.inventoryCapacityVol?.toString() ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ComponentText(type: 'page_title', text: "Inventory Detail"),
        getInputLabel("Name"),
        ComponentInput(
            ctrl: inventoryNameCtrl,
            hinttext: "ex : plate",
            maxLength: 75,
            type: 'text'),
        getInputLabel("Category"),
        GetAllDctByType(
            type: 'inventory_category',
            selected: selectedInventoryCat,
            action: (value) {
              setState(() {
                selectedInventoryCat = value;
              });
            }),
        getInputLabel("Description"),
        ComponentInput(
          ctrl: inventoryDescCtrl,
          hinttext: "ex : this plate is good and cheap",
          maxLength: 255,
          type: 'text',
          maxLines: 5,
        ),
        getInputLabel("Merk"),
        ComponentInput(
            ctrl: inventoryMerkCtrl,
            hinttext: "ex : awesome plate",
            maxLength: 75,
            type: 'text'),
        getInputLabel("Price"),
        ComponentInput(
            ctrl: inventoryPriceCtrl,
            hinttext: "0",
            maxLength: 9,
            type: 'number'),
        getDivider(),
        const ComponentText(type: 'page_title', text: "Standard Capacity"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInputLabel("Volume"),
                    ComponentInput(
                        ctrl: inventoryVolCtrl,
                        hinttext: "0",
                        maxLength: 6,
                        type: 'number'),
                  ],
                )),
            const Spacer(),
            SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInputLabel("Unit"),
                    GetAllDctByType(
                        type: 'inventory_unit',
                        selected: selectedInventoryUnit,
                        action: (value) {
                          setState(() {
                            selectedInventoryUnit = value;
                          });
                        })
                  ],
                ))
          ],
        ),
        getDivider(),
        const ComponentText(type: 'page_title', text: "Remaining Capacity"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInputLabel("Volume"),
                    ComponentInput(
                        ctrl: inventoryCapVolCtrl,
                        hinttext: "0",
                        maxLength: 6,
                        type: 'number'),
                  ],
                )),
            const Spacer(),
            SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInputLabel("Unit"),
                    GetAllDctByType(
                        type: 'inventory_unit',
                        selected: selectedInventoryUnitCap,
                        action: (value) {
                          setState(() {
                            selectedInventoryUnitCap = value;
                          });
                        })
                  ],
                ))
          ],
        ),
        getDivider(),
        const ComponentText(type: 'page_title', text: "Placement"),
        getInputLabel("Room"),
        GetAllDctByType(
            type: 'inventory_room',
            selected: selectedInventoryRoom,
            action: (value) {
              setState(() {
                selectedInventoryRoom = value;
              });
            }),
        getInputLabel("Storage"),
        ComponentInput(
            ctrl: inventoryStorageCtrl,
            hinttext: "ex : wardobe",
            maxLength: 36,
            secure: false,
            type: 'text'),
        getInputLabel("Rack"),
        ComponentInput(
            ctrl: inventoryRackCtrl,
            hinttext: "ex : shelf A",
            maxLength: 36,
            secure: false,
            type: 'text'),
        const ComponentText(type: 'page_title', text: "Reminder"),
        reminder != null && reminder.isNotEmpty
            ? Column(
                children: reminder.map((el) => GetReminder(data: el)).toList(),
              )
            : PostReminder(
                isExist: true,
                id: widget.id,
                inventoryName: detail.inventoryName,
              ),
        const ComponentText(type: 'page_title', text: "Report"),
        GetReportByInventoryId(
            inventoryName: detail.inventoryName, inventoryId: widget.id)
      ],
    );
  }
}
