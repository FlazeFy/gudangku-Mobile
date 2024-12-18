import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/api/inventory/service/queries.dart';

class GenerateDocSection extends StatefulWidget {
  const GenerateDocSection({Key? key, required this.id, required this.type})
      : super(key: key);
  final String id;
  final String type;

  @override
  State<GenerateDocSection> createState() => _GenerateDocSectionState();
}

class _GenerateDocSectionState extends State<GenerateDocSection> {
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
      child: FutureBuilder<String?>(
        future: apiService?.getDetailDoc(widget.id),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return _buildHtmlView(snapshot.data);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildHtmlView(String? dt) {
    return Html(
      style: {
        "body": Style(
          padding: HtmlPaddings(
            left: HtmlPadding(spaceMD),
            right: HtmlPadding(spaceMD),
            top: HtmlPadding(spaceMD),
            bottom: HtmlPadding(spaceMD),
          ),
          color: Colors.black,
          backgroundColor: whiteColor,
        ),
      },
      data: dt ?? "<p>No content available</p>",
    );
  }
}
