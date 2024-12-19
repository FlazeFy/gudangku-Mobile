import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/dictionary/model/queries.dart';
import 'package:gudangku/modules/api/dictionary/service/queries.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/converter.dart';

class GetAllDctByType extends StatefulWidget {
  const GetAllDctByType(
      {super.key, this.type, this.action, required this.selected, this.dct});
  final String? type;
  final String selected;
  final dynamic action;
  final List<DctModel>? dct;

  @override
  StateGetAllDctByType createState() => StateGetAllDctByType();
}

class StateGetAllDctByType extends State<GetAllDctByType> {
  late DictionaryQueriesService apiHistoryQuery;
  int i = 0;
  List<DctModel> dt = [];
  bool isLoading = true;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    apiHistoryQuery = DictionaryQueriesService();
    selectedValue = widget.selected;
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      List<DctModel> apiData = [];
      List<DctModel> providedData = [];

      if (widget.type != null) {
        apiData = await apiHistoryQuery.getDctByType(widget.type!);
      }
      if (widget.dct != null) {
        providedData = List<DctModel>.from(widget.dct!);
      }

      dt = [
        ...apiData,
        ...providedData,
        DctModel(dctName: '-'),
      ];

      dt = dt.toSet().toList();

      if (!dt.any((element) => element.dctName == selectedValue)) {
        selectedValue = null;
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryColor),
      );
    }

    return SafeArea(
      maintainBottomViewPadding: false,
      child: _buildListView(dt),
    );
  }

  Widget _buildListView(List<DctModel> data) {
    if (data.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(bottom: spaceSM),
        child: DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: spaceMD),
          ),
          hint: const Text(
            'Select Total Type',
            style: TextStyle(fontSize: textMD, color: whiteColor),
          ),
          value: selectedValue,
          items: data
              .map((item) => DropdownMenuItem<String>(
                    value: item.dctName,
                    child: Text(
                      ucAll(item.dctName),
                      style:
                          const TextStyle(fontSize: textMD, color: whiteColor),
                    ),
                  ))
              .toList(),
          validator: (value) {
            if (value == null) {
              return 'Please select total type';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            widget.action(value);
          },
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
        ),
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
