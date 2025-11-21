import 'package:flutter/material.dart';
import 'package:gudangku/modules/api/report/model/queries.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';

class GetImagesReport extends StatefulWidget {
  const GetImagesReport(
      {super.key, required this.reportImages, required this.onReload});
  final List<ReportImage>? reportImages;
  final VoidCallback onReload;

  @override
  StateGetImagesReport createState() => StateGetImagesReport();
}

class StateGetImagesReport extends State<GetImagesReport> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const ComponentText(type: 'content_title', text: "Attached Images"),
      const SizedBox(height: spaceMD),
      if (widget.reportImages!.isEmpty)
        const ComponentText(text: "No Image Attached", type: "no_data"),
      if (widget.reportImages!.isNotEmpty)
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: spaceMD,
          mainAxisSpacing: spaceMD,
          physics: const NeverScrollableScrollPhysics(),
          children: widget.reportImages!.map((img) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(roundedMD),
              child: Image.network(
                img.url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const ComponentText(
                      text: "Image Failed To Load", type: "no_data");
                },
              ),
            );
          }).toList(),
        )
    ]);
  }
}
