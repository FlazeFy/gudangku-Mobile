import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/converter.dart';
import 'package:gudangku/views/stats/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToggleTotal extends StatefulWidget {
  const ToggleTotal({Key? key}) : super(key: key);

  @override
  StateToggleTotalState createState() => StateToggleTotalState();
}

class StateToggleTotalState extends State<ToggleTotal> {
  final List<String> genderItems = [
    'item',
    'price',
  ];

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'filter',
      onPressed: () {
        Get.dialog(AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: null,
          backgroundColor: darkColor,
          content: SizedBox(
            width: Get.width,
            height: 200,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: spaceMD, right: spaceMD, top: spaceMD),
                    child: Row(children: [
                      const ComponentText(
                          type: 'content_title', text: 'Stats Control'),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          foregroundColor:
                              MaterialStateProperty.all(whiteColor),
                          side: MaterialStateProperty.all(
                              const BorderSide(color: dangerBG, width: 1.5)),
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ]),
                  ),
                  const Divider(),
                  Container(
                      padding: const EdgeInsets.only(
                          left: spaceMD, right: spaceMD, top: spaceMD),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ComponentText(
                                type: 'content_title', text: 'Toggle Type'),
                            DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: spaceMD),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(roundedMD),
                                    borderSide:
                                        const BorderSide(color: primaryColor)),
                              ),
                              hint: const Text(
                                'Select Total Type',
                                style: TextStyle(
                                    fontSize: textMD, color: whiteColor),
                              ),
                              value: statsType,
                              items: genderItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          ucAll(item),
                                          style: const TextStyle(
                                              fontSize: textMD,
                                              color: whiteColor),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select total type';
                                }
                                return null;
                              },
                              onChanged: (value) async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                statsType = value.toString();
                                const keys = [
                                  'total-inventory-by-cat-item-sess',
                                  'total-inventory-by-cat-price-sess',
                                  'last-hit-total-inventory-by-cat-item-sess',
                                  'last-hit-total-inventory-by-cat-price-sess',
                                  'total-inventory-by-fav-item-sess',
                                  'total-inventory-by-fav-price-sess',
                                  'last-hit-total-inventory-by-fav-item-sess',
                                  'last-hit-total-inventory-by-fav-price-sess',
                                  'total-inventory-by-room-item-sess',
                                  'total-inventory-by-room-price-sess',
                                  'last-hit-total-inventory-by-room-item-sess',
                                  'last-hit-total-inventory-by-room-price-sess',
                                  'total-inventory-by-merk-item-sess',
                                  'total-inventory-by-merk-price-sess',
                                  'last-hit-total-inventory-by-merk-item-sess',
                                  'last-hit-total-inventory-by-merk-price-sess',
                                ];
                                for (var el in keys) {
                                  prefs.remove(el);
                                }
                                globalStatsTabController!.index = 0;
                                Get.to(const StatsPage());
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
                                    borderRadius:
                                        BorderRadius.circular(roundedLG),
                                    border: Border.all(
                                        color: whiteColor.withOpacity(0.75),
                                        width: 1)),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding:
                                    EdgeInsets.symmetric(horizontal: spaceMD),
                              ),
                            )
                          ])),
                ]),
          ),
        ));
      },
      backgroundColor: primaryColor,
      child: const FaIcon(
        FontAwesomeIcons.filter,
        color: whiteColor,
      ),
    );
  }
}
