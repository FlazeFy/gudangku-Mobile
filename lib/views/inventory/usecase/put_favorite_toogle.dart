import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/model/commands.dart';
import 'package:gudangku/modules/api/inventory/service/commands.dart';
import 'package:gudangku/modules/component/dialog/failed_dialog.dart';
import 'package:gudangku/modules/component/navbar.dart';
import 'package:gudangku/modules/global/style.dart';

class FavoriteToogle extends StatefulWidget {
  final bool isFavorite;
  final String id;

  const FavoriteToogle({Key? key, required this.isFavorite, required this.id})
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
        child: IconButton(
          onPressed: () {
            FavoriteToogleModel dt =
                FavoriteToogleModel(isFavorite: widget.isFavorite ? 0 : 1);

            apiInventoryCommand
                .toogleFavInventoryById(widget.id, dt)
                .then((response) {
              setState(() => {});
              var status = response[0]['message'];
              var body = response[0]['body'];

              if (status == "success") {
                Get.to(const BottomBar());
              } else {
                Get.dialog(FailedDialog(text: body, type: "toogleFavorite"));
              }
            });
          },
          icon: const FaIcon(FontAwesomeIcons.heart, color: whiteColor),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                widget.isFavorite ? dangerBG : Colors.transparent),
            foregroundColor: MaterialStateProperty.all(whiteColor),
            side: MaterialStateProperty.all(BorderSide(
                color: widget.isFavorite ? dangerBG : dangerBG, width: 1.5)),
          ),
        ));
  }
}
