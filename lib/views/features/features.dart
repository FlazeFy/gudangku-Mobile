import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';

class FeatureList extends StatefulWidget {
  const FeatureList({Key? key}) : super(key: key);

  @override
  StateFeatureListState createState() => StateFeatureListState();
}

class StateFeatureListState extends State<FeatureList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ComponentText(
            type: 'page_title', color: primaryColor, text: 'Our Features'),
        ClipRRect(
          borderRadius: BorderRadius.circular(roundedJumbo + roundedJumbo),
          child: Image.asset('assets/images/inventory.png',
              width: Get.width * 0.5),
        ),
        const ComponentText(
            type: 'content_title',
            align: TextAlign.center,
            text: 'Inventory Management Made Effortless'),
        const ComponentText(
            type: 'content_body',
            align: TextAlign.center,
            text:
                'Tired of keeping track of your inventory in a messy notebook or forgetting what tools or supplies you have at home? Say goodbye to the hassle with GudangKu! Our app allows you to create a detailed, organized list of all your belongings. Track everything—from the name, category, and color, to images, prices, brands, volume, placement, and more. GudangKu streamlines your inventory management, making it easier than ever to search for and find exactly what you need, when you need it.'),
        const SizedBox(height: spaceJumbo),
        ClipRRect(
          borderRadius: BorderRadius.circular(roundedJumbo + roundedJumbo),
          child:
              Image.asset('assets/images/report.png', width: Get.width * 0.5),
        ),
        const ComponentText(type: 'content_title', text: 'Instant Reporting'),
        const ComponentText(
            type: 'content_body',
            align: TextAlign.center,
            text:
                "With GudangKu, you can generate reports for any context! Create customized checklists, wishlist inventories, shopping carts, wash lists, or simply store your receipts and bills. Whether you're analyzing your stock, tracking purchases, or sharing data with others, our reporting feature allows you group your item and share it with others. No more manual scrambling for information—GudangKu makes reporting seamless and efficient."),
        const SizedBox(height: spaceJumbo),
        ClipRRect(
          borderRadius: BorderRadius.circular(roundedJumbo + roundedJumbo),
          child:
              Image.asset('assets/images/layout.png', width: Get.width * 0.5),
        ),
        const ComponentText(type: 'content_title', text: 'Visual Room Layouts'),
        const ComponentText(
            type: 'content_body',
            align: TextAlign.center,
            text:
                "GudangKu goes beyond just lists and catalogs—get a visual representation of your belongings with our interactive floor plan feature! You can map out where each item is stored, whether in a specific room, on a shelf, or in a storage unit. Choose between 2D or 3D room views to get a clear, intuitive layout of your space. With this feature, you'll know exactly where everything is, and you can easily analyze storage usage and item distribution across your home or business."),
        const SizedBox(height: spaceJumbo),
        ClipRRect(
          borderRadius: BorderRadius.circular(roundedJumbo + roundedJumbo),
          child:
              Image.asset('assets/images/reminder.png', width: Get.width * 0.5),
        ),
        const ComponentText(
            type: 'content_title', text: 'Never Miss a Reminder Again!'),
        const ComponentText(
            type: 'content_body',
            align: TextAlign.center,
            text:
                "Life gets busy, and it's easy to forget when it's time to clean or restock items. But with GudangKu's Reminder feature, you'll never miss a beat! Set custom reminders for daily, weekly, or monthly tasks like cleaning your kitchen set, restocking supplies, or washing seasonal items. Receive notifications via Telegram Bot Chat or Mobile App Alerts, keeping your schedule on track and your inventory in perfect order."),
        const SizedBox(height: spaceJumbo),
        ClipRRect(
          borderRadius: BorderRadius.circular(roundedJumbo + roundedJumbo),
          child:
              Image.asset('assets/images/document.png', width: Get.width * 0.5),
        ),
        const ComponentText(
            type: 'content_title', text: 'Comprehensive Stats & Analytics'),
        const ComponentText(
            type: 'content_body',
            align: TextAlign.center,
            text:
                "Gain valuable insights into your inventory with GudangKu's rich data presentation! Beyond basic lists, we offer charts or detailed analytics in paragraph format that help you understand your inventory like never before. Track the most expensive items, analyze average prices, discover which categories you have the most of, find similar items, and uncover patterns that can optimize your storage and purchasing habits. GudangKu helps you take your inventory management to the next level with data-driven decision-making."),
        const SizedBox(height: spaceJumbo),
        ClipRRect(
          borderRadius: BorderRadius.circular(roundedJumbo + roundedJumbo),
          child: Image.asset('assets/images/print.png', width: Get.width * 0.5),
        ),
        const ComponentText(
            type: 'content_title', text: 'Digital Document Generator'),
        const ComponentText(
            type: 'content_body',
            align: TextAlign.center,
            text:
                "Save, modify, and share your inventory data in digital formats like CSV or PDF. GudangKu makes it easy to generate reports and documents tailored to your needs. Whether you're importing CSV files to quickly add multiple items or analyzing reports in PDF format, you can import, edit, and share your inventory documents with ease. The app also helps you cross-reference and add items from external documents with just one click, providing even more powerful insights and helping you optimize your inventory management."),
        Container(
            margin: const EdgeInsets.symmetric(vertical: spaceLG),
            child: const ComponentText(
                type: 'content_sub_title',
                color: primaryColor,
                align: TextAlign.center,
                text: "- Smart Inventory, Easy Life -")),
      ],
    );
  }
}
