import 'package:ceosi_app/constants/uid.dart';
import 'package:ceosi_app/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/colors.dart';
import 'widgets/banner_widget.dart';
import 'widgets/buttons/dropdown_item_widget.dart';
import 'widgets/drawer_widget.dart';
import 'widgets/header/header_widget.dart';
import 'widgets/product/product_list_widget.dart';
import 'widgets/search_delegate/search_delegate_item_widget.dart';

class RewardHomeScreen extends ConsumerStatefulWidget {
  const RewardHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RewardHomeScreenState();
}

class _RewardHomeScreenState extends ConsumerState<RewardHomeScreen> {
  int _dropdownValue = 0;

  String itemCategory = 'Snacks';

  // @override
  // void initState() {
  //   super.initState();
  //   getUserPoints();
  // }

  getUserPoints() async {
    var collection = FirebaseFirestore.instance
        .collection('CEOSI-USERS-NEW')
        .where('id', isEqualTo: FirebaseAuthToken().uid);

    var querySnapshot = await collection.get();

    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          ref.read(getUserPointsProvider.notifier).state = data['user_points'];
        }
      });
    }
  }

  final Stream<DocumentSnapshot> categoryData = FirebaseFirestore.instance
      .collection('CEOSI-REWARDS-UTILITIES')
      .doc('categories')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('CEOSI-USERS-NEW')
        .where('id', isEqualTo: 'h1yOarARHIdto9e45iZqZV9aE042')
        .snapshots()
        .listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            print('Added');
            break;
          case DocumentChangeType.modified:
            print(DocumentChangeType.modified.name);
            break;
          case DocumentChangeType.removed:
            print('Removed');
            break;
        }
      }
    });
    // final docRef = FirebaseFirestore.instance
    //     .collection('CEOSI-USERS-NEW')
    //     .doc('BdtHURblEaSJ2l6Ld3d5eBufiju2');
    // docRef
    //     .snapshots(
    //   includeMetadataChanges: true,
    // )
    //     .listen((event) {
    //   print('${event.metadata} this is an event');
    // });

    // DocumentReference reference = FirebaseFirestore.instance.collection('collection').doc("document");
    // reference.snapshots().listen((querySnapshot) {

    //   setState(() {
    //     print(querySnapshot.get('field'));
    //   });

    // });

    print(DateTime.now());
    return Scaffold(
      drawer: const DrawerWidget(),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                HeaderWidget(
                  headerTitle: 'HOME',
                ),
                const BannerWidget(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GestureDetector(
                onTap: () {
                  getUserPoints();
                  showSearch(
                      context: context, delegate: SearchDelegateProduct());
                },
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.search,
                        color: CustomColors.primary,
                      ),
                      const Expanded(child: SizedBox()),
                      StreamBuilder<DocumentSnapshot>(
                          stream: categoryData,
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: Text('Loading'));
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Something went wrong'));
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            dynamic data = snapshot.data;
                            List categList = data['category'];
                            return SizedBox(
                              width: 120,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 2, 20, 2),
                                child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  iconEnabledColor: Colors.black,
                                  isExpanded: true,
                                  value: _dropdownValue,
                                  items: [
                                    for (int i = 0; i < categList.length; i++)
                                      DropdownMenuItem(
                                        onTap: () {
                                          itemCategory = data['category'][i];
                                        },
                                        value: i,
                                        child: DropDownItem(
                                            label: data['category'][i]),
                                      ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _dropdownValue =
                                          int.parse(value.toString());
                                    });
                                  },
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ProductListWidget(
                query: itemCategory,
              ),
            )
          ],
        ),
      ),
    );
  }
}
