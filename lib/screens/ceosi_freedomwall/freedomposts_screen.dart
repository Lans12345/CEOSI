import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/user_search_screen.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/widgets/freedomwallbutton_widget.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/widgets/masonry_list_widget.dart';
import 'package:ceosi_app/widgets/sidebar_navigation_column_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/sidebar_widget.dart';

class FreedomPostsScreen extends StatefulWidget {
  final DateTime? from;
  final DateTime? until;
  final String? anonName;
  final String? mood;
  const FreedomPostsScreen(
      {super.key, this.mood, this.from, this.until, this.anonName});

  @override
  State<FreedomPostsScreen> createState() => _FreedomPostsScreenState();
}

class _FreedomPostsScreenState extends State<FreedomPostsScreen>
    with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    //     Future.delayed(const Duration(seconds: 5), () {
    //   print('times up 100');
    // });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UserSearchScreenArguments;
    Size size = MediaQuery.of(context).size;

    print(args.anonName);
    print('ANON TYPE${args.anonName}'.runtimeType);
    print(args.mood);

    final Stream<QuerySnapshot> freedomPostsStream = FirebaseFirestore.instance
        .collection('CEOSI-FREEDOMWALL-FREEDOMPOSTS')
        .orderBy('created', descending: true)
        .where('created',
            isGreaterThanOrEqualTo: args.from?.add(const Duration(hours: 0)))
        .where('created',
            isLessThanOrEqualTo: args.until?.add(const Duration(hours: 24)))
        .where('anon_name', isEqualTo: args.anonName)
        .where('mood', isEqualTo: args.mood)
        .snapshots();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: const SidebarWidget(
            navigationColumn: SidebarNavigationColumnWidget()),
        appBar: AppBar(
          backgroundColor: CustomColors.primary,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20.0),
              child: SizedBox(
                width: size.width,
                child: Center(
                  child: TabBar(
                    isScrollable: true,
                    labelColor: Colors.white,
                    indicatorColor: const Color.fromRGBO(8, 120, 93, 3),
                    unselectedLabelColor: Colors.grey,
                    controller: tabController,
                    tabs: const [
                      Text('FREEDOM WALL \u{1F4DD}'),
                      Text('MY FREEDOM POSTS \u{1F4D2}'),
                    ],
                  ),
                ),
              )),
        ),
        body: TabBarView(controller: tabController, children: [
          Stack(children: [
            MasonryListWidget(
                iscontinuousIconVisible: false, stream: freedomPostsStream),
            const FreedomWallButtonWidget(theHeader: '                '),
          ]),
          Stack(children: [
            MasonryListWidget(
              iscontinuousIconVisible: true,
              stream: FirebaseFirestore.instance
                  .collection('CEOSI-FREEDOMWALL-FREEDOMPOSTS')
                  .where('user_id',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
            ),
            const FreedomWallButtonWidget(theHeader: '                '),
          ]),
        ]),
      ),
    );
  }
}
