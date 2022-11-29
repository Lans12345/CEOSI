import 'dart:math';

import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/widgets/ink_well_widget.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/widgets/masontry_text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/icons.dart';
import '../../../services/navigation.dart';
import '../user_single_freedom_post_screen.dart';

class MasonryListWidget extends StatefulWidget {
  const MasonryListWidget(
      {required this.stream, required this.iscontinuousIconVisible, super.key});

  final Stream<QuerySnapshot<Object?>>? stream;
  final bool iscontinuousIconVisible;
  @override
  State<MasonryListWidget> createState() => _MasonryListWidgetState();
}

deleteExpiredPost(DateTime expiration, String? index) {
  if (DateTime.now().isAfter(expiration) ||
      DateTime.now().isAtSameMomentAs(expiration)) {
    FirebaseFirestore.instance
        .collection('CEOSI-FREEDOMWALL-FREEDOMPOSTS')
        .doc(index)
        .delete();
  }
}

class _MasonryListWidgetState extends State<MasonryListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot?>(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'You have no saved Posts!',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.fromLTRB(20, 100, 20, 12),
            child: MasonryGridView.builder(
              physics: const BouncingScrollPhysics(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 6,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map data = snapshot.data!.docs[index].data() as Map;
                DateTime created = data['created'].toDate();
                DateTime expiration = data['expiration'].toDate();

                String formattedTime =
                    DateFormat.yMMMd().add_jm().format(created);
                deleteExpiredPost(expiration, snapshot.data!.docs[index].id);
                Random random = Random();
                int randomNumber = random.nextInt(8) + 1;
                Color backgroudColor =
                    CustomColors().masonryListbackgroundColors[(randomNumber)];

                return MasonryItem(
                  continuousIconVisibility: widget.iscontinuousIconVisible,
                  backgroudColor: backgroudColor,
                  content: data['content'],
                  anonname: data['anon_name'],
                  date: formattedTime,
                  id: snapshot.data!.docs[index].id,
                  user_id: data['user_id'],
                  mood: data['mood'],
                );
              },
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
            ),
          );
        } else {
          return const Center(
            child: Text('Loading...'),
          );
        }
      },
    );
  }
}

class MasonryItem extends StatelessWidget {
  MasonryItem(
      {Key? key,
      required this.backgroudColor,
      required this.content,
      required this.continuousIconVisibility,
      this.id,
      this.user_id,
      required this.mood,
      required this.date,
      required this.anonname})
      : super(key: key);

  final Color backgroudColor;
  final String content;
  final String? id;
  final String? user_id;
  final String date;
  final String anonname;
  final bool continuousIconVisibility;
  final String mood;

  final List<TextStyle> tempFontLists = [
    GoogleFonts.justAnotherHand(fontSize: 20),
    GoogleFonts.cedarvilleCursive(fontSize: 20),
    GoogleFonts.fasterOne(fontSize: 20),
    GoogleFonts.bangers(fontSize: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Stack(children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                ),
                padding: const EdgeInsets.fromLTRB(5, 30, 5, 5),
                child: Stack(children: [
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 300,
                      child: Card(
                        color: backgroudColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MasonryTextWidget(
                                text: content,
                                presetFontSizes: const [20, 14, 12],
                                style: tempFontLists[Random().nextInt(4)],
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MasonryTextWidget(
                                text: date,
                                presetFontSizes: const [12],
                                textAlign: TextAlign.right,
                              ),
                              MasonryTextWidget(
                                text: 'by: $anonname',
                                presetFontSizes: const [12],
                                textAlign: TextAlign.right,
                              ),
                              MasonryTextWidget(
                                text: mood,
                                presetFontSizes: const [12],
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: user_id));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: MasonryTextWidget(
                      text: 'COPY ID \u{29C9} ',
                      presetFontSizes: const [12],
                      style: tempFontLists[3],
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                InkWellWidget(
                  visible: continuousIconVisibility,
                  childWidget: Image.asset(
                    CustomIcons().continuousdoticon,
                    height: 30,
                    width: 30,
                  ),
                  onTap: () {
                    Navigation(context)
                        .goToUserSingleFreedomPostScreen(MaterialPageRoute(
                      builder: (context) => UserSingleFreedomPostScreen(
                        id: id,
                        content: content,
                        mood: mood,
                      ),
                    ));
                  },
                ),
              ])
            ]),
          ],
        ),
      ),
    );
  }
}
