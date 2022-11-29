import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/services/navigation.dart';
import 'package:ceosi_app/widgets/button_widget.dart';
import 'package:ceosi_app/widgets/sidebar_widget.dart';
import 'package:ceosi_app/widgets/sidebar_navigation_column_widget.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../constants/images.dart';
import '../constants/labels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: const SidebarWidget(
            navigationColumn: SidebarNavigationColumnWidget()),
        appBar: AppBar(
          backgroundColor: CustomColors.greyAccent,
          leading: Builder(
              builder: (context) => IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  )),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  Images.coesiIcon,
                  width: 60,
                ),
                const SizedBox(
                  height: 40,
                ),
                ButtonWidget(
                  color: CustomColors.primary,
                  borderRadius: 20,
                  onPressed: () {
                    Navigation(context).goToCatalogEntriesScreen();
                  },
                  buttonHeight: 100,
                  buttonWidth: 300,
                  textWidget: const BoldTextWidget(
                      color: Colors.white,
                      fontSize: 15,
                      text: Labels.ceosiFlutterCatalog),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                  color: CustomColors.primary,
                  borderRadius: 20,
                  onPressed: () {
                    Navigation(context).goToFreedomPostsScreen();
                  },
                  buttonHeight: 100,
                  buttonWidth: 300,
                  textWidget: const BoldTextWidget(
                      color: Colors.white,
                      fontSize: 15,
                      text: Labels.ceosiFreedomWall),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                  color: CustomColors.primary,
                  borderRadius: 20,
                  onPressed: () {
                    Navigation(context).goToAnnouncementScreen();
                  },
                  buttonHeight: 100,
                  buttonWidth: 300,
                  textWidget: const BoldTextWidget(
                      color: Colors.white,
                      fontSize: 15,
                      text: Labels.ceosiCompanyApp),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                  color: CustomColors.primary,
                  borderRadius: 20,
                  onPressed: () {
                    Navigation(context).goToRewardHomeScreen();
                  },
                  buttonHeight: 100,
                  buttonWidth: 300,
                  textWidget: const BoldTextWidget(
                      color: Colors.white,
                      fontSize: 15,
                      text: Labels.ceosiRewards),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
