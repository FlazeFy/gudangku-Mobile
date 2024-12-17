import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/inventory/service/queries.dart';

class EditorSection extends StatefulWidget {
  const EditorSection({Key? key, required this.id, required this.type})
      : super(key: key);
  final String id;
  final String type;

  @override
  StateEditorSectionState createState() => StateEditorSectionState();
}

class StateEditorSectionState extends State<EditorSection> {
  InventoryQueriesService? apiService;

  @override
  void initState() {
    super.initState();
    apiService = InventoryQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getDetailDoc(widget.id),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            String? contents = snapshot.data;

            return _buildListView(contents);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(String? dt) {
    return SizedBox(height: Get.height, child: const Column(children: []));
  }
}
