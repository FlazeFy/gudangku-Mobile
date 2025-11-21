import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gudangku/modules/api/report/model/queries.dart';
import 'package:gudangku/modules/api/report/service/queries.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/dialog/rest_time_dialog.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/detail_report/usecases/delete_report.dart';
import 'package:gudangku/views/detail_report/usecases/get_detail_report.dart';
import 'package:gudangku/views/detail_report/usecases/get_images_report.dart';
import 'package:gudangku/views/detail_report/usecases/get_items_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailReportPage extends StatefulWidget {
  const DetailReportPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  StateDetailReportPageState createState() => StateDetailReportPageState();
}

class StateDetailReportPageState extends State<DetailReportPage> {
  late ReportQueriesService apiReportQuery;
  int i = 0;
  List<InventoryReportModel> items = [];
  late ReportDetailModel detail;
  bool isLoading = false;
  String viewType = "catalog";

  @override
  void initState() {
    super.initState();
    apiReportQuery = ReportQueriesService();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    var data = await apiReportQuery.getDetailReport(widget.id);
    final prefs = await SharedPreferences.getInstance();
    viewType = prefs.getString('toogle_edit_report') ?? "false";
    setState(() {
      detail = data?['detail'];
      items = data?['items'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : _buildListView(detail, items),
    );
  }

  Widget _buildListView(
      ReportDetailModel detail, List<InventoryReportModel> items) {
    return Scaffold(
        appBar: ComponentAppBar(
          title: 'Report Detail',
          isSubMenu: true,
          extraButton: [getRestTimeDialog('Dictionary', dctFetchRestTime)],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: spaceMD),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('toogle_edit_report',
                        viewType == 'false' ? 'true' : 'false');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailReportPage(id: widget.id)),
                    );
                  },
                  child: ComponentButton(
                    type: viewType == 'false'
                        ? 'button_primary'
                        : 'button_danger',
                    text: "${viewType == 'false' ? 'Open' : 'Close'} Edit",
                    icon: FaIcon(
                      viewType == 'false'
                          ? FontAwesomeIcons.penToSquare
                          : FontAwesomeIcons.xmark,
                      color: whiteColor,
                      size: textMD,
                    ),
                  ),
                ),
                DeleteReport(id: detail.id)
              ],
            ),
            const SizedBox(height: spaceMD),
            GetDetailReport(
                isEdit: viewType == 'false' ? false : true, data: detail),
            const SizedBox(height: spaceMD),
            GetImagesReport(
                reportImages: detail.reportImage, onReload: loadData),
            const SizedBox(height: spaceMD),
            GetItemsReport(
                data: items,
                reportName: detail.reportTitle,
                onReload: loadData),
            const FooterBar()
          ],
        ));
  }
}
