import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/screens/ceosi_company_app/widgets/drawer_widget.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: CustomColors.greyAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const BoldTextWidget(
                color: Colors.black, fontSize: 23, text: 'Announcements'),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(children: [
                    InkWell(onTap: (() {}), child: const AnnouncementList())
                  ]);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const BoldTextWidget(
                color: Colors.black, fontSize: 23, text: 'Upcoming Events'),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Column(children: [
                    InkWell(onTap: (() {}), child: const EventList())
                  ]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnnouncementList extends StatelessWidget {
  const AnnouncementList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: CustomColors.primary,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.campaign,
                size: 50,
                color: CustomColors.secondary,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    BoldTextWidget(
                        color: Colors.white,
                        fontSize: 14,
                        text: 'Emergency Meeting'),
                    NormalTextWidget(
                        color: Colors.white,
                        fontSize: 13,
                        text: 'October 25, 2022'),
                    NormalTextWidget(
                        color: Colors.white, fontSize: 13, text: '10:00 AM')
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class EventList extends StatelessWidget {
  const EventList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: CustomColors.primary,
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.event,
                size: 50,
                color: CustomColors.secondary,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    BoldTextWidget(
                        color: Colors.white,
                        fontSize: 14,
                        text: 'CEOSI Town-Hall Meeting & Halloween Party'),
                    NormalTextWidget(
                        color: Colors.white,
                        fontSize: 13,
                        text: 'October 25, 2022'),
                    NormalTextWidget(
                        color: Colors.white, fontSize: 13, text: '3:00 PM')
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
