import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/models/ceosi_freedomwall/model.dart';
import 'package:ceosi_app/screens/ceosi_freedomwall/widgets/piechart_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ceosi_app/widgets/sidebar_navigation_column_widget.dart';
import 'package:flutter/material.dart';
import '../../widgets/sidebar_widget.dart';
import '../../widgets/text_widget.dart';

class PieChartReportScreen extends StatefulWidget {
  const PieChartReportScreen({super.key});

  @override
  State<PieChartReportScreen> createState() => _PieChartReportScreenState();
}

class _PieChartReportScreenState extends State<PieChartReportScreen> {
  Map<String, double> nulldatamap = {
    'Empty': 100,
  };
  late List<Post> _mood = [];

  Map<String, double> getCategoryData() {
    Map<String, double> catMap = {};
    for (var item in _mood) {
      // print(item.mood);
      if (catMap.containsKey(item.mood) == false) {
        catMap[item.mood] = 1;
      } else {
        catMap.update(item.mood, (int) => catMap[item.mood]! + 1);
        // test[item.category] = test[item.category]! + 1;
      }
      // print(catMap);
    }
    return catMap;
  }

  final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
      .collection('CEOSI-FREEDOMWALL-FREEDOMPOSTS')
      // .orderBy('created', descending: true)
      // .where('created',
      //     isGreaterThanOrEqualTo: DateTime.parse('2022-11-00 00:00:00.000'))
      // .where('created',
      //     isLessThanOrEqualTo: DateTime.parse('2022-12-00 00:00:00.000'))
      // .where('anon_name', isEqualTo: 'Thoughtless_Viper')
      // .where('id', isEqualTo: 'S7n26yLf1XkMXcxoFdCh')
      .snapshots();

  void getFromSnapShot(snapshot) {
    if (snapshot.docs.isNotEmpty) {
      _mood = [];
      for (int i = 0; i < snapshot.docs.length; i++) {
        var a = snapshot.docs[i];

        Post mood = Post.fromJson(a.data());
        _mood.add(mood);
      }
    }
  }

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
          backgroundColor: CustomColors.primary,
        ),
        body: Stack(children: [
          pieChartSceenButtonandText(),
          StreamBuilder<Object>(
            stream: dataStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final data = snapshot.requireData;
              // print('Data: $data');
              getFromSnapShot(data);
              return PieChartWidget(
                dataMap:
                    getCategoryData().isEmpty ? nulldatamap : getCategoryData(),
                centerText: 'MOOD',
              );
            },
          )
        ]),
      ),
    );
  }

  Padding pieChartSceenButtonandText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 580),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                BoldTextWidget(
                    color: Colors.black,
                    fontSize: 20,
                    text: 'Pie Chart Report Screen'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
