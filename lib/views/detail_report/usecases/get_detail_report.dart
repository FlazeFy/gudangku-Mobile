import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/report/model/queries.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/detail_report/usecases/put_detail_report.dart';

class GetDetailReport extends StatefulWidget {
  const GetDetailReport({super.key, required this.data, required this.isEdit});
  final bool isEdit;
  final ReportDetailModel data;

  @override
  StateGetDetailReport createState() => StateGetDetailReport();
}

class StateGetDetailReport extends State<GetDetailReport> {
  @override
  Widget build(BuildContext context) {
    return widget.isEdit
        ? PutDetailReport(id: widget.data.id, data: widget.data)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ComponentText(type: 'page_title', text: widget.data.reportTitle),
              ComponentButton(
                  type: 'button_tag', text: widget.data.reportCategory),
              const SizedBox(height: spaceLG),
              ComponentText(
                  type:
                      widget.data.reportDesc != '' ? 'content_body' : 'no_data',
                  text: widget.data.reportDesc != ''
                      ? widget.data.reportDesc ?? '-'
                      : 'No description provided'),
              const SizedBox(height: spaceJumbo),
              widget.data.reportCategory == 'Shopping Cart' ||
                      widget.data.reportCategory == 'Wishlist'
                  ? Row(
                      children: [
                        ComponentText(
                            type: 'content_title',
                            text:
                                'Total Price : Rp. ${widget.data.totalPrice}'),
                        const Spacer(),
                        ComponentText(
                            type: 'content_title',
                            text: 'Total Item : ${widget.data.totalItem}')
                      ],
                    )
                  : const SizedBox()
            ],
          );
  }
}
