import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/constants/icons.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/admin_panel_search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ceosi_app/widgets/sidebar_navigation_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../services/navigation.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/sidebar_widget.dart';
import '../../widgets/text_widget.dart';

class AdminPostsDataScreen extends StatefulWidget {
  final String? anonName;
  final String? id;
  const AdminPostsDataScreen({super.key, this.anonName, this.id});

  @override
  State<AdminPostsDataScreen> createState() => _AdminPostsDataScreenState();
}

class _AdminPostsDataScreenState extends State<AdminPostsDataScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as AdminPanelSearchScreenArguments;
    print('ANON ${args.anonName}');
    print('ID ${args.id}');
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: const SidebarWidget(
            navigationColumn: SidebarNavigationColumnWidget()),
        appBar: AppBar(
          backgroundColor: CustomColors.primary,
        ),
        body: Stack(children: [
          Center(
              child: Column(
            children: const [
              SizedBox(
                height: 25,
              ),
              BoldTextWidget(
                  color: Colors.black, fontSize: 30, text: 'ADMIN PANEL'),
            ],
          )),
          SingleChildScrollView(child: adminPanelButtons()),
          const ListViewSeparatedHeader(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 250, 10, 20),
            child: FirestoreListView(
                physics: const BouncingScrollPhysics(),
                pageSize: 5,
                errorBuilder: (context, error, stackTrace) {
                  return Text(error.toString());
                },
                loadingBuilder: (context) {
                  return const CircularProgressIndicator();
                },
                itemBuilder: (context, snapshot) {
                  final user = snapshot.data();
                  return ListViewSeparatedItem(
                    id: user['id'],
                    email: user['email'],
                    anon: user['anon_name'],
                  );
                },
                query: FirebaseFirestore.instance
                    .collection('CEOSI-USERS-NEW')
                    .where('anon_name', isEqualTo: args.anonName)
                    .where('id', isEqualTo: args.id)),
          ),
        ]),
      ),
    );
  }

  Padding adminPanelButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const BoldTextWidget(
                    color: Colors.black, fontSize: 20, text: 'DATA'),
                ButtonWidget(
                    borderRadius: 20,
                    onPressed: () {
                      Navigation(context).goToFreedomPostsScreen();
                    },
                    buttonHeight: 70,
                    buttonWidth: 70,
                    textWidget: Image.asset(CustomIcons().freedompostsicon,
                        fit: BoxFit.contain)),
                ButtonWidget(
                    borderRadius: 20,
                    onPressed: () {
                      Navigation(context).goToPiechartReportScreen();
                    },
                    buttonHeight: 70,
                    buttonWidth: 70,
                    textWidget: Image.asset(
                      CustomIcons().piecharticon,
                      fit: BoxFit.contain,
                    )),
                ButtonWidget(
                    borderRadius: 20,
                    onPressed: () async {
                      Navigation(context).goToAdminPanelSearchScreen();
                    },
                    buttonHeight: 70,
                    buttonWidth: 70,
                    textWidget: Image.asset(CustomIcons().filtericon,
                        fit: BoxFit.contain)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewSeparatedHeader extends StatelessWidget {
  const ListViewSeparatedHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 220, 20, 0),
      child: Container(
        color: CustomColors.primary,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              BoldTextWidget(
                color: Colors.white,
                fontSize: 10,
                text: 'USER ID         ',
              ),
              BoldTextWidget(
                color: Colors.white,
                fontSize: 10,
                text: '    Email Address',
              ),
              BoldTextWidget(
                color: Colors.white,
                fontSize: 10,
                text: '    Anonymous Name',
              ),
            ]),
      ),
    );
  }
}

class ListViewSeparatedItem extends StatefulWidget {
  const ListViewSeparatedItem({
    Key? key,
    required this.id,
    required this.email,
    required this.anon,
  }) : super(key: key);

  final String id;
  final String email;
  final String anon;

  @override
  State<ListViewSeparatedItem> createState() => _ListViewSeparatedItemState();
}

class _ListViewSeparatedItemState extends State<ListViewSeparatedItem> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: NormalTextWidget(
                textAlign: TextAlign.center,
                color: Colors.black,
                fontSize: 14,
                text: widget.id,
              ),
            ),
            Expanded(
              child: NormalTextWidget(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                color: const Color.fromARGB(255, 104, 103, 103),
                fontSize: 14,
                text: isObscure == true
                    ? widget.email.replaceAll(RegExp(r'.'), '\u{2733}')
                    : widget.email,
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: NormalTextWidget(
                  color: Colors.black,
                  fontSize: 14,
                  text: widget.anon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
