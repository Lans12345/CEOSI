import 'package:ceosi_app/screens/ceosi_freedomwall/admin_panel_search_screen.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/source_code_screen.dart';
import 'package:flutter/material.dart';

import '../constants/routes.dart';
import '../screens/ceosi_freedomwall/user_search_screen.dart';

class Navigation {
  Navigation(this.context);

  BuildContext context;

  goToMainScreen() {
    Navigator.of(context).pushNamed(Routes.mainscreen);
  }

  goToLoginScreen() {
    Navigator.pushNamed(context, Routes.loginscreen);
  }

  goToHomeScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.homescreen, (route) => false);
  }

  goToRegisterScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.registerscreen, (route) => false);
  }

  goToAnnouncementScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.announcementscreen, (route) => false);
  }

  goToAddAnnouncementScreen() {
    Navigator.of(context).pushNamed(Routes.addannouncementscreen);
  }

  goToTeamScreen() {
    Navigator.of(context).pushNamed(Routes.teamscreen);
  }

  goToAddTeamScreen() {
    Navigator.of(context).pushNamed(Routes.addteamscreen);
  }

  goToAboutScreen() {
    Navigator.of(context).pushNamed(Routes.aboutscreen);
  }

  goToFreedomPostsScreen(
      {String? mood, DateTime? from, DateTime? until, String? anonName}) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.freedompostsscreen, (route) => false,
        arguments: UserSearchScreenArguments(mood, from, until, anonName));
  }

  goToAddFreedomPostsScreen() {
    Navigator.of(context).pushNamed(Routes.addfreedompostscreen);
  }

  goToCatalogEntriesScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.catalogentriesscreen, (route) => false);
  }

  goToSourceCodeScreen() {
    Navigator.of(context).pushNamed(Routes.sourcecodescreen);
  }

  goToEventCalendarScreen() {
    Navigator.of(context).pushNamed(Routes.eventcalendarscreen);
  }

  goToUserSearchScreen() {
    Navigator.of(context).pushNamed(Routes.usersearchscreen);
  }

  goToPiechartReportScreen() {
    Navigator.of(context).pushNamed(Routes.piechartreportscreen);
  }

  goToPiechartSearchScreen() {
    Navigator.of(context).pushNamed(Routes.piechartsearchscreen);
  }

  goToAddCatalogEntryScreen() {
    Navigator.of(context).pushNamed(Routes.addcatalogentryscreen);
  }

  goToRewardHomeScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.rewardhomescreen, (route) => false);
  }

  goToRewardViewItemScreen() {
    Navigator.of(context).pushNamed(Routes.rewardviewitemscreen);
  }

  goToProfileScreenReward() {
    Navigator.of(context).pushNamed(Routes.profilescreenreward);
  }

  goToAdminPanelScreenReward() {
    Navigator.of(context).pushNamed(Routes.adminpanelscreenreward);
  }

  goToAdminPostsDataScreen({String? id, String? anonName}) {
    Navigator.of(context).pushNamed(Routes.adminpostsdatascreen,
        arguments: AdminPanelSearchScreenArguments(id, anonName));
  }

  goToUserSingleFreedomPostScreen(MaterialPageRoute materialPageRoute) {
    Navigator.of(context).push(materialPageRoute);
  }

  goToUserContributionsScreen() {
    Navigator.of(context).pushNamed(Routes.usercontributionsscreen);
  }

  goToEditCatalogEntryScreen(String title) {
    Navigator.of(context).pushNamed(Routes.editcatalogentryscreen,
        arguments: EditCatalogEntryArguments(title));
  }

  goToForgotPasswordScreen() {
    Navigator.of(context).pushNamed(Routes.forgotpasswordscreen);
  }

  goToAdminPanelSearchScreen() {
    Navigator.of(context).pushNamed(Routes.adminpanelsearchscreen);
  }
}
