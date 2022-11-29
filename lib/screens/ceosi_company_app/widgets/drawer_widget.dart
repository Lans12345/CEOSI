import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/constants/images.dart';
import 'package:ceosi_app/widgets/button_widget.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0))),
      backgroundColor: CustomColors.greyAccent,
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.menu,
                      size: 26.0,
                    )),
              ],
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  Images.coesiIcon,
                  width: 60,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ButtonWidget(
                      onPressed: () {
                        Navigator.pushNamed(context, '/announcementscreen');
                      },
                      buttonHeight: 55.0,
                      buttonWidth: 203.0,
                      borderRadius: 10.0,
                      textWidget: const BoldTextWidget(
                          color: Colors.white,
                          fontSize: 12.0,
                          text: 'Announcement'),
                    ),
                    const SizedBox(height: 25.0),
                    ButtonWidget(
                      onPressed: () {
                        Navigator.pushNamed(context, '/eventcalendarscreen');
                      },
                      buttonHeight: 55.0,
                      buttonWidth: 203.0,
                      borderRadius: 10.0,
                      textWidget: const BoldTextWidget(
                          color: Colors.white,
                          fontSize: 12.0,
                          text: 'Event Calendar'),
                    ),
                    const SizedBox(height: 25.0),
                    ButtonWidget(
                      onPressed: () {
                        Navigator.pushNamed(context, '/teamscreen');
                      },
                      buttonHeight: 55.0,
                      buttonWidth: 203.0,
                      borderRadius: 10.0,
                      textWidget: const BoldTextWidget(
                          color: Colors.white,
                          fontSize: 12.0,
                          text: 'The Team'),
                    ),
                    const SizedBox(height: 25.0),
                    ButtonWidget(
                      onPressed: () {
                        Navigator.pushNamed(context, '/aboutscreen');
                      },
                      buttonHeight: 55.0,
                      buttonWidth: 203.0,
                      borderRadius: 10.0,
                      textWidget: const BoldTextWidget(
                          color: Colors.white, fontSize: 12.0, text: 'About'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
