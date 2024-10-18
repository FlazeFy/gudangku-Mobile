import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/dictionary/model/queries.dart';
import 'package:gudangku/modules/api/dictionary/service/queries.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/converter.dart';

class GetAllDctByType extends StatefulWidget {
  const GetAllDctByType(
      {super.key, required this.type, this.action, required this.selected});
  final String type;
  final String selected;
  final dynamic action;

  @override
  StateGetAllDctByType createState() => StateGetAllDctByType();
}

class StateGetAllDctByType extends State<GetAllDctByType> {
  late DictionaryQueriesService apiHistoryQuery;
  int i = 0;
  List<DctModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    apiHistoryQuery = DictionaryQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiHistoryQuery.getDctByType(widget.type),
        builder:
            (BuildContext context, AsyncSnapshot<List<DctModel>> snapshot) {
          if (snapshot.hasError) {
            // Get.dialog(FailedDialog(
            //     text: "Unknown error, please contact the admin",
            //     type: "error"));
            return const Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<DctModel> contents = snapshot.data ?? [];
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

  Widget _buildListView(List<DctModel> data) {
    if (data.isNotEmpty) {
      data.add(DctModel(dctName: '-'));
      return DropdownButtonFormField2<String>(
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        hint: const Text(
          'Select Total Type',
          style: TextStyle(fontSize: textMD, color: whiteColor),
        ),
        value: widget.selected,
        items: data
            .map((item) => DropdownMenuItem<String>(
                  value: item.dctName,
                  child: Text(
                    ucAll(item.dctName),
                    style: const TextStyle(fontSize: textMD, color: whiteColor),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select total type';
          }
          return null;
        },
        onChanged: widget.action,
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: whiteColor,
          ),
          iconSize: textJumbo,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
              color: darkColor,
              borderRadius: BorderRadius.circular(roundedLG),
              border:
                  Border.all(color: whiteColor.withOpacity(0.75), width: 1)),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: spaceMD),
        ),
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
