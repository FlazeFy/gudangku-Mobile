import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/text.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutList extends StatefulWidget {
  const AboutList({Key? key}) : super(key: key);

  @override
  StateAboutListState createState() => StateAboutListState();
}

class StateAboutListState extends State<AboutList> {
  @override
  Widget build(BuildContext context) {
    IconButton getSocmedButton(String link, IconData icon) {
      return IconButton(
          onPressed: () async {
            final Uri url = Uri.parse(link);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              throw 'Could not launch $url';
            }
          },
          icon: FaIcon(
            icon,
            color: whiteColor,
          ));
    }

    return Column(
      children: [
        const ComponentText(
            type: 'page_title', color: primaryColor, text: 'About GudangKu'),
        const ComponentText(
            type: 'content_body',
            align: TextAlign.center,
            text:
                "GudangKu revolutionizes inventory management, making it effortless to organize and track your belongings. Whether you're managing household items or business supplies, our app lets you create detailed lists with categories, images, prices, and more, so everything you need is just a tap away. With interactive visual layouts in 2D or 3D, you can map out storage spaces and instantly locate items, making organization intuitive and efficient."),
        const SizedBox(height: spaceMD),
        const ComponentText(
            type: 'content_body',
            align: TextAlign.center,
            text:
                "Beyond basic inventory tracking, GudangKu offers powerful features like custom reporting, reminders, and advanced analytics. Set reminders for cleaning or restocking, generate tailored reports, and gain insights into your inventory through charts and data-driven analysis. With the ability to save and share data in CSV or PDF formats, GudangKu streamlines decision-making and enhances collaboration, making it the ultimate tool for smarter, hassle-free inventory management."),
        const SizedBox(height: spaceLG),
        const ComponentText(
            type: 'page_title', color: primaryColor, text: 'About Creator'),
        Container(
            padding: const EdgeInsets.all(spaceXMD),
            decoration: BoxDecoration(
                border: Border.all(color: whiteColor, width: 1),
                borderRadius:
                    const BorderRadius.all(Radius.circular(roundedMD))),
            child: Column(children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(roundedJumbo + roundedJumbo),
                child: Image.asset('assets/images/male.png',
                    width: Get.width * 0.35),
              ),
              const SizedBox(height: spaceMD),
              const ComponentText(
                  type: 'content_body',
                  align: TextAlign.center,
                  text:
                      "My Name is Leo, a Bachelor's degree graduate in Software Engineering from Telkom University (2023). Focused on Web Development and Mobile Development. Enjoys exploring new knowledge and seeking challenges. If you want to do collaboration or do you want to send me feedback? you can find me on :"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getSocmedButton(
                      "https://www.instagram.com/leonardhorante_08/",
                      FontAwesomeIcons.instagram),
                  getSocmedButton(
                      "https://www.linkedin.com/in/leonardho-rante-sitanggang-a5a752202/",
                      FontAwesomeIcons.linkedin),
                  getSocmedButton(
                      "https://github.com/FlazeFy", FontAwesomeIcons.github),
                  getSocmedButton(
                      "mailto:flazen.edu@gmail.com", FontAwesomeIcons.envelope),
                ],
              )
            ])),
        const SizedBox(height: spaceLG),
        const ComponentText(
            type: 'page_title', color: primaryColor, text: 'About Stack'),
        const ComponentText(
            type: 'content_body',
            align: TextAlign.center,
            text:
                "For development of GudangKu apps, we use Laravel for the Web Apps, Flutter for the Mobile Apps, and Python for the Telegram Bot."),
      ],
    );
  }
}
