import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/widgets/sidebar_navigation_column_widget.dart';
import 'package:flutter/material.dart';
import '../../constants/icons.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/sidebar_widget.dart';
import '../../widgets/text_widget.dart';
import 'package:intl/intl.dart';

import '../../widgets/textformfield_widget.dart';

class PieChartSearchScreen extends StatefulWidget {
  const PieChartSearchScreen({super.key});

  @override
  State<PieChartSearchScreen> createState() => _PieChartSearchScreenState();
}

class _PieChartSearchScreenState extends State<PieChartSearchScreen> {
  final _searcheduserController = TextEditingController();
  DateTimeRange? dateRange;

  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange!.end);
    }
  }

  Future pickDateRange(BuildContext context) async {
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange,
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  Object? mood;

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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                  child: TextformfieldWidget(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    maxLines: 1,
                    hintText: 'Enter Freedom Post ID (FP ID)',
                    radius: 20,
                    isObscure: false,
                    textFieldController: _searcheduserController,
                    label: '',
                    colorFill: Colors.black12,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: ButtonWidget(
                      borderRadius: 20,
                      onPressed: () {
                        pickDateRange(context);
                        print(dateRange);
                      },
                      buttonHeight: 53,
                      buttonWidth: 150,
                      textWidget: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NormalTextWidget(
                                color: Colors.white,
                                fontSize: 18,
                                text: dateRange == null
                                    ? 'Date Range'
                                    : '${getFrom().toString()} - ${getUntil().toString()}'),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        CustomIcons().datepickericon),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  height: 365,
                ),
                ButtonWidget(
                    borderRadius: 20,
                    onPressed: () {},
                    buttonHeight: 53,
                    buttonWidth: 182,
                    textWidget: const NormalTextWidget(
                        color: Colors.white, fontSize: 18, text: 'Search')),
                const SizedBox(
                  height: 250,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
