import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/uid.dart';
import '../../../widgets/text_widget.dart';
import 'buttons/drawer_button_widget.dart';
import 'dialogs/logout_prompt_dialog_widget.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('CEOSI-USERS-NEW')
        .doc(FirebaseAuthToken().uid)
        .snapshots();
    return Drawer(
      backgroundColor: CustomColors.primary,
      child: StreamBuilder<DocumentSnapshot>(
          stream: userData,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Loading'));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            dynamic data = snapshot.data;
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Divider(
                    color: Colors.white,
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        data['profile_image'],
                        height: 90,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 130,
                            child: BoldTextWidget(
                                color: Colors.white,
                                fontSize: 18,
                                text: data['name']),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          NormalTextWidget(
                              color: Colors.white,
                              fontSize: 14,
                              text: data['position']),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Divider(
                    color: Colors.white,
                    thickness: 1.5,
                  ),
                ),
                DrawerButtonWidget(
                    icon: Icons.home,
                    onPressed: () {
                      Navigator.pushNamed(context, '/rewardhomescreen');
                    },
                    text: 'HOME'),
                data['position'] != 'Admin'
                    ? DrawerButtonWidget(
                        icon: Icons.person,
                        onPressed: () {
                          Navigator.pushNamed(context, '/profilescreenreward');
                        },
                        text: 'PROFILE')
                    : const SizedBox(),
                DrawerButtonWidget(
                    icon: Icons.info,
                    onPressed: () {
                      showAboutDialog(
                          context: context,
                          applicationName: 'CEOSI Rewards',
                          applicationIcon: Image.asset(
                            CustomImages.coesiIcon,
                            height: 20,
                          ),
                          applicationLegalese:
                              'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum',
                          applicationVersion: 'v1.0');
                    },
                    text: 'ABOUT'),
                data['position'] == 'Admin'
                    ? DrawerButtonWidget(
                        icon: Icons.admin_panel_settings_rounded,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/adminpanelscreenreward');
                        },
                        text: 'ADMIN')
                    : const SizedBox(),
                data['position'] == 'Admin'
                    ? DrawerButtonWidget(
                        icon: Icons.settings,
                        onPressed: () {
                          Navigator.pushNamed(context, '/configscreen');
                        },
                        text: 'CONFIG')
                    : const SizedBox(),
                DrawerButtonWidget(
                    icon: Icons.logout,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return const LogoutPromptDialogWidget();
                          }));
                    },
                    text: 'LOGOUT'),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                            CustomImages.coesiLogoCompleteAndMaroonBlueText),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const NormalTextWidget(
                    color: Colors.white,
                    fontSize: 10,
                    text: 'All right reserved'),
                const NormalTextWidget(
                    color: Colors.white,
                    fontSize: 10,
                    text: 'Cyber Ensemble Outsourcing Services Inc.  2022'),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
    );
  }
}
