import 'package:ceosi_app/screens/ceosi_flutter_catalog/add_catalog_entry_screen.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/catalog_entries_screen.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/edit_catalog_entry_screen.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/user_contributions_screen.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/add_freedom_post_screen.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/source_code_screen.dart';
import 'package:ceosi_app/screens/ceosi_company_app/add_announcement_screen.dart';
import 'package:ceosi_app/screens/ceosi_company_app/add_team_screen.dart';
import 'package:ceosi_app/screens/ceosi_company_app/event_calendar_screen.dart';
import 'package:ceosi_app/screens/ceosi_company_app/team_screen.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/admin_panel_search_screen.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/freedomposts_screen.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/admin_posts_data_screen.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/pie_chart_report_screen.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/piechart_search_screen.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/user_search_screen.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/user_single_freedom_post_screen.dart';
import 'package:ceosi_app/screens/forgot_password_screen.dart';
import 'package:ceosi_app/screens/ceosi_rewards/config_screen.dart';
import 'package:ceosi_app/screens/ceosi_rewards/widgets/product/add_product_screen.dart';
import 'package:ceosi_app/screens/login_screen.dart';
import 'package:ceosi_app/screens/home_screen.dart';
import 'package:ceosi_app/screens/main_screen.dart';
import 'package:ceosi_app/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants/routes.dart';
import 'screens/ceosi_company_app/about_screen.dart';
import 'screens/ceosi_company_app/announcement_screen.dart';
import 'constants/labels.dart';
import 'screens/ceosi_rewards/admin_panel_screen.dart';
import 'screens/ceosi_rewards/profile_screen.dart';
import 'screens/ceosi_rewards/reward_home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/ceosi_rewards/view_item_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        errorColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.mainscreen,
      routes: {
        Routes.mainscreen: (context) => const MainScreen(),
        Routes.loginscreen: (context) => const LoginScreen(),
        Routes.homescreen: (context) => const HomeScreen(),
        Routes.registerscreen: (context) => const RegisterScreen(),
        Routes.forgotpasswordscreen: (context) => const ForgotPasswordScreen(),
        Routes.announcementscreen: (context) => const AnnouncementScreen(),
        Routes.addannouncementscreen: (context) =>
            const AddAnnouncementScreen(),
        Routes.teamscreen: (context) => const TeamScreen(),
        Routes.addteamscreen: (context) => const AddTeamScreen(),
        Routes.aboutscreen: (context) => const AboutScreen(),
        Routes.freedompostsscreen: (context) => const FreedomPostsScreen(),
        Routes.addfreedompostscreen: (context) => const AddFreedomPostScreen(),
        Routes.catalogentriesscreen: (context) => const CatalogEntriesScreen(),
        Routes.sourcecodescreen: (context) => const SourceCodeScreen(),
        Routes.eventcalendarscreen: (context) => const EventCalendarScreen(),
        Routes.usersearchscreen: (context) => const UserSearchScreen(),
        Routes.piechartreportscreen: (context) => const PieChartReportScreen(),
        Routes.piechartsearchscreen: (context) => const PieChartSearchScreen(),
        Routes.addcatalogentryscreen: (context) => AddCatalogEntryScreen(),
        Routes.rewardhomescreen: (context) => const RewardHomeScreen(),
        Routes.rewardviewitemscreen: (context) => const RewardViewItemScreen(),
        Routes.profilescreenreward: (context) => const ProfileScreenReward(),
        Routes.adminpanelscreenreward: (context) => const AdminPanelScreen(),
        Routes.adminpostsdatascreen: (context) => const AdminPostsDataScreen(),
        Routes.usercontributionsscreen: (context) =>
            const UserContributionsScreen(),
        Routes.editcatalogentryscreen: (context) =>
            const EditCatalogEntryScreen(),
        Routes.usersinglefreedompostscreen: (context) =>
            const UserSingleFreedomPostScreen(),
        '/addproductscreen': (context) => const AddProductPage(),
        '/configscreen': (context) => ConfigScreen(),
        Routes.adminpanelsearchscreen: (context) =>
            const AdminPanelSearchScreen(),
      },
      title: Labels.ceosiApp,
    );
  }
}
