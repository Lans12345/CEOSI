import 'package:flutter/material.dart';

import '../../../constants/icons.dart';
import '../../../services/navigation.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/text_widget.dart';

class FreedomWallButtonWidget extends StatefulWidget {
  final String theHeader;

  const FreedomWallButtonWidget({super.key, required this.theHeader});

  @override
  State<FreedomWallButtonWidget> createState() =>
      _FreedomWallButtonWidgetState();
}

class _FreedomWallButtonWidgetState extends State<FreedomWallButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BoldTextWidget(
                    color: Colors.black, fontSize: 20, text: widget.theHeader),
                ButtonWidget(
                    borderRadius: 20,
                    onPressed: () {
                      Navigation(context).goToPiechartReportScreen();
                    },
                    buttonHeight: 70,
                    buttonWidth: 70,
                    textWidget: Image.asset(CustomIcons().piecharticon,
                        fit: BoxFit.contain)),
                ButtonWidget(
                    borderRadius: 20,
                    onPressed: () {
                      Navigation(context).goToUserSearchScreen();
                    },
                    buttonHeight: 70,
                    buttonWidth: 70,
                    textWidget: Image.asset(CustomIcons().filtericon,
                        fit: BoxFit.contain)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(256, 520, 12, 0),
              child: ButtonWidget(
                  borderRadius: 100,
                  onPressed: () {
                    Navigation(context).goToAddFreedomPostsScreen();
                  },
                  buttonHeight: 70,
                  buttonWidth: 70,
                  textWidget:
                      Image.asset(CustomIcons().plusicon, fit: BoxFit.contain)),
            ),
          ],
        ),
      ),
    );
  }
}
