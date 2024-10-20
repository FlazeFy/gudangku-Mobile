import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/report/model/queries.dart';
import 'package:gudangku/modules/api/report/service/queries.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/dialog/rest_time_dialog.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/detail_report/usecases/get_detail_report.dart';
import 'package:gudangku/views/detail_report/usecases/get_items_report.dart';

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
          padding: const EdgeInsets.only(
              top: spaceJumbo, left: spaceMD, right: spaceMD),
          children: [
            GetDetailReport(data: detail),
            const SizedBox(height: spaceMD),
            GetItemsReport(data: items)
          ],
        ));
  }
}
