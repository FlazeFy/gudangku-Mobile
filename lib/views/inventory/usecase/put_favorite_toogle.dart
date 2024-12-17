import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/model/commands.dart';
import 'package:gudangku/modules/api/inventory/service/commands.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/dialog/success_dialog.dart';
import 'package:gudangku/modules/global/style.dart';

class FavoriteToogle extends StatefulWidget {
  final bool isFavorite;
  final String id;
  final VoidCallback onReload;

  const FavoriteToogle(
      {Key? key,
      required this.isFavorite,
      required this.id,
      required this.onReload})
      : super(key: key);

  @override
  StateFavoriteToogle createState() => StateFavoriteToogle();
}

class StateFavoriteToogle extends State<FavoriteToogle> {
  late InventoryCommandsService apiInventoryCommand;

  @override
  void initState() {
    super.initState();

    apiInventoryCommand = InventoryCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(spaceSM),
        child: InkWell(
          onTap: () {
            FavoriteToogleModel dt =
                FavoriteToogleModel(isFavorite: widget.isFavorite ? 0 : 1);

            apiInventoryCommand
                .toogleFavInventoryById(widget.id, dt)
                .then((response) {
              setState(() => {});
              var status = response[0]['status'];
              var msg = response[0]['message'];

              if (status == "success") {
                widget.onReload();
                Get.dialog(SuccessDialog(text: msg));
              } else {
                Get.dialog(FailedDialog(text: msg, type: "toogleFavorite"));
              }
            });
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: spaceSM),
              decoration: BoxDecoration(
                  color: widget.isFavorite ? dangerBG : Colors.transparent,
                  border: Border.all(color: dangerBG, width: 1),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(roundedMD))),
              child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.heart,
                      size: textLG,
                    )
                  ])),
        ));
  }
}
