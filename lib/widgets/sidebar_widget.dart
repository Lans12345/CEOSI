import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/constants/uid.dart';
import 'package:ceosi_app/models/sidebar_user_model.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/confirmation_dialog.dart';
import 'package:ceosi_app/services/navigation.dart';
import 'package:ceosi_app/widgets/button_widget.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/labels.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget(
      {super.key, required this.navigationColumn, this.adminButtonNavigation});

  final Widget navigationColumn;
  final VoidCallback? adminButtonNavigation;

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String id = '';
  String name = '';
  String position = '';
  String profileImage = '';
  QueryDocumentSnapshot<Map<String, dynamic>>? doc;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
  }

  Future<SidebarUserModel> readUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('CEOSI-USERS-NEW')
        .where('id', isEqualTo: uid)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        id = doc['id'];
        name = doc['name'];
        position = doc['position'];
        profileImage = doc['profile_image'];
      }
    });
    return SidebarUserModel(
        id: id, name: name, position: position, profileImage: profileImage);
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('CEOSI-USERS-NEW')
        .doc(FirebaseAuthToken().uid)
        .snapshots();

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
                      color: CustomColors.primary,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder<DocumentSnapshot>(
                stream: userData,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text('Loading'));
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  dynamic data = snapshot.data;
                  if (data['position'] == 'Admin') {
                    isAdmin = true;
                  }
                  return Stack(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRect(
                          child: Image.network(
                            data['profile_image'],
                            height: 75,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              BoldTextWidget(
                                color: Colors.black,
                                fontSize: 16.0,
                                text: data['name'],
                              ),
                              NormalTextWidget(
                                color: Colors.black,
                                fontSize: 10.0,
                                text: data['position'],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 120),
                      child: Visibility(
                        visible: isAdmin,
                        child: ButtonWidget(
                          color: CustomColors.secondary,
                          onPressed: () =>
                              Navigation(context).goToAdminPostsDataScreen(),
                          buttonHeight: 55.0,
                          buttonWidth: 253.0,
                          borderRadius: 10.0,
                          textWidget: const BoldTextWidget(
                              color: Colors.white,
                              fontSize: 12.0,
                              text: 'Admin Panel'),
                        ),
                      ),
                    )
                  ]);
                },
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      widget.navigationColumn,
                      FutureBuilder(
                        future: readUser(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else if (snapshot.hasData) {
                            SidebarUserModel user = snapshot.data;
                            bool isAdmin =
                                user.position == 'Admin' ? true : false;

                            return Visibility(
                              visible: isAdmin,
                              replacement: Container(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  const SizedBox(height: 25.0),
                                  ButtonWidget(
                                    color: CustomColors.secondary,
                                    onPressed: widget.adminButtonNavigation ??
                                        () => Navigation(context)
                                            .goToHomeScreen(),
                                    buttonHeight: 55.0,
                                    buttonWidth: 203.0,
                                    borderRadius: 10.0,
                                    textWidget: const BoldTextWidget(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        text: Labels.adminPanel),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset('assets/images/FINAL-LOGO-1.2.png'),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      widget.navigationColumn,
                      FutureBuilder(
                        future: readUser(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else if (snapshot.hasData) {
                            SidebarUserModel user = snapshot.data;
                            bool isAdmin =
                                user.position == 'Admin' ? true : false;

                            return Visibility(
                              visible: isAdmin,
                              replacement: Container(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  const SizedBox(height: 25.0),
                                  ButtonWidget(
                                    color: CustomColors.secondary,
                                    onPressed: widget.adminButtonNavigation ??
                                        () => Navigation(context)
                                            .goToHomeScreen(),
                                    buttonHeight: 55.0,
                                    buttonWidth: 203.0,
                                    borderRadius: 10.0,
                                    textWidget: const BoldTextWidget(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        text: Labels.adminPanel),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Flexible(
              flex: 1,
              child: LogoutButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationColumn extends StatelessWidget {
  const NavigationColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ButtonWidget(
          onPressed: () => Navigation(context).goToCatalogEntriesScreen(),
          buttonHeight: 55.0,
          buttonWidth: 203.0,
          borderRadius: 10.0,
          textWidget: const BoldTextWidget(
              color: Colors.white,
              fontSize: 12.0,
              text: Labels.ceosiFlutterCatalog),
        ),
        const SizedBox(height: 25.0),
        ButtonWidget(
          onPressed: () => Navigation(context).goToFreedomPostsScreen(),
          buttonHeight: 55.0,
          buttonWidth: 203.0,
          borderRadius: 10.0,
          textWidget: const BoldTextWidget(
              color: Colors.white,
              fontSize: 12.0,
              text: Labels.ceosiFreedomWall),
        ),
        const SizedBox(height: 25.0),
        ButtonWidget(
          onPressed: () => Navigation(context).goToAnnouncementScreen(),
          buttonHeight: 55.0,
          buttonWidth: 203.0,
          borderRadius: 10.0,
          textWidget: const BoldTextWidget(
              color: Colors.white,
              fontSize: 12.0,
              text: Labels.ceosiCompanyApp),
        ),
        const SizedBox(height: 25.0),
        ButtonWidget(
          onPressed: () => Navigation(context).goToRewardHomeScreen(),
          buttonHeight: 55.0,
          buttonWidth: 203.0,
          borderRadius: 10.0,
          textWidget: const BoldTextWidget(
              color: Colors.white, fontSize: 12.0, text: Labels.ceosiRewards),
        ),
        const SizedBox(height: 25.0),
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: ButtonWidget(
            onPressed: () {
              ConfirmationDialog(context).dialog(
                title: Labels.logoutConfirmationTitle,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigation(context).goToLoginScreen();
                },
              );
            },
            buttonHeight: 42.0,
            buttonWidth: 57,
            borderRadius: 10.0,
            textWidget: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
