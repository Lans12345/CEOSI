import 'package:ceosi_app/screens/ceosi_rewards/widgets/buttons/dropdown_item_widget.dart';
import 'package:ceosi_app/screens/ceosi_rewards/widgets/product/admin_product_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import 'widgets/dialogs/add_coin_dialog_widget.dart';
import 'widgets/dialogs/subtract_coin_dialog_widget.dart';
import 'widgets/drawer_widget.dart';
import 'widgets/header/header_admin_panel_widget.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  bool _index = true;
  bool _index1 = false;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      body: Center(
        child: Column(
          children: [
            const HeaderAdminPanelWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(
                    avatar: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.groups_sharp,
                        color: Colors.white,
                      ),
                    ),
                    onSelected: ((value) {
                      setState(() {
                        _index = true;
                        _index1 = false;
                        _currentIndex = 0;
                      });
                    }),
                    selectedColor: CustomColors.primary,
                    label: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: NormalTextWidget(
                          color: Colors.white, fontSize: 12, text: 'USERS'),
                    ),
                    selected: _index),
                ChoiceChip(
                    avatar: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.card_giftcard_rounded,
                        color: Colors.white,
                      ),
                    ),
                    selectedColor: CustomColors.primary,
                    onSelected: ((value) {
                      setState(() {
                        _index1 = true;
                        _index = false;
                        _currentIndex = 1;
                      });
                    }),
                    label: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: NormalTextWidget(
                          color: Colors.white, fontSize: 12, text: 'REWARDS'),
                    ),
                    selected: _index1)
              ],
            ),
            Expanded(
              child: SizedBox(
                child: IndexedStack(
                  index: _currentIndex,
                  children: const [
                    ListUsersWidget(),
                    AdminListReward(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListUsersWidget extends StatefulWidget {
  const ListUsersWidget({super.key});

  @override
  State<ListUsersWidget> createState() => _ListUsersWidgetState();
}

class _ListUsersWidgetState extends State<ListUsersWidget> {
  late int _dropdownValue = 0;

  String itemCategory = 'All';

  query() {
    if (_dropdownValue == 0) {
      return FirebaseFirestore.instance
          .collection('CEOSI-USERS-NEW')
          .where('position', isNotEqualTo: 'Admin')
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('CEOSI-USERS-NEW')
          .where('position', isEqualTo: itemCategory)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: query(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('error');
            return const Center(child: Text('Error'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('waiting');
            return const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            );
          }

          final data = snapshot.requireData;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: SizedBox(
                  width: 350,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: DropdownButton(
                        underline: Container(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        isExpanded: true,
                        value: _dropdownValue,
                        items: [
                          DropdownMenuItem(
                            onTap: () {
                              itemCategory = 'All';
                            },
                            value: 0,
                            child: DropDownItem(label: 'All'),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              itemCategory = 'Flutter Developer';
                            },
                            value: 1,
                            child: DropDownItem(label: 'Flutter Developer'),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              itemCategory = 'Fontend Developer';
                            },
                            value: 2,
                            child: DropDownItem(label: 'Fontend Developer'),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              itemCategory = 'Backend Developer';
                            },
                            value: 3,
                            child: DropDownItem(label: 'Backend Developer'),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              itemCategory = 'Backend Developer';
                            },
                            value: 4,
                            child: DropDownItem(label: 'Quality Assurance'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _dropdownValue = int.parse(value.toString());
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data?.size ?? 0,
                      itemBuilder: ((context, index) {
                        return UsersWidget(
                          name: data.docs[index]['name'],
                          position: data.docs[index]['position'],
                          userPoints: data.docs[index]['user_points'],
                          profileImage: data.docs[index]['profile_image'],
                          id: data.docs[index]['id'],
                        );
                      })),
                ),
              ),
            ],
          );
        });
  }
}

// ignore: must_be_immutable
class UsersWidget extends StatefulWidget {
  late String name;
  late String position;
  late int userPoints;
  late String profileImage;
  late String id;

  UsersWidget(
      {super.key,
      required this.name,
      required this.position,
      required this.userPoints,
      required this.profileImage,
      required this.id});

  @override
  State<UsersWidget> createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: widget.position == 'Admin'
          ? widget.id == FirebaseAuth.instance.currentUser!.uid
              ? Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.network(
                        widget.profileImage,
                        height: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                              width: 120,
                              child: BoldTextWidget(
                                  color: Colors.black,
                                  fontSize: 12,
                                  text: 'YOU')),
                          NormalTextWidget(
                              color: Colors.black,
                              fontSize: 10,
                              text: widget.position),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.network(
                        widget.profileImage,
                        height: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 120,
                              child: BoldTextWidget(
                                  color: Colors.black,
                                  fontSize: 12,
                                  text: widget.name)),
                          NormalTextWidget(
                              color: Colors.black,
                              fontSize: 10,
                              text: widget.position),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
          : Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.network(
                    widget.profileImage,
                    height: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 120,
                          child: BoldTextWidget(
                              color: Colors.black,
                              fontSize: 12,
                              text: widget.name)),
                      NormalTextWidget(
                          color: Colors.black,
                          fontSize: 10,
                          text: widget.position),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SubractCoinDialog(
                                id: widget.id,
                                name: widget.name,
                                position: widget.position,
                                profileImage: widget.profileImage,
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: CustomColors.primary,
                      )),
                  BoldTextWidget(
                      color: CustomColors.primary,
                      fontSize: 18,
                      text: '${widget.userPoints}cc'),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AddCoinDialogWidget(
                                id: widget.id,
                                name: widget.name,
                                position: widget.position,
                                profileImage: widget.profileImage,
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: CustomColors.primary,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
    );
  }
}

class AdminListReward extends StatelessWidget {
  const AdminListReward({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ProductListWidgetAdminPanel(),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ButtonWidget(
                borderRadius: 100,
                onPressed: () {
                  Navigator.pushNamed(context, '/addproductscreen');
                },
                buttonHeight: 50,
                buttonWidth: 300,
                textWidget: const BoldTextWidget(
                    color: Colors.white, fontSize: 18, text: 'ADD PRODUCT'),
                color: CustomColors.primary),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable

