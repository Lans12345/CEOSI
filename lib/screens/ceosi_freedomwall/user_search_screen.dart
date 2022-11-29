import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/services/navigation.dart';
import 'package:ceosi_app/widgets/sidebar_navigation_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/icons.dart';
import '../../widgets/button_widget.dart';
import 'widgets/dropdown_button_form_field_widget.dart';
import '../../widgets/sidebar_widget.dart';
import '../../widgets/text_widget.dart';
import 'package:intl/intl.dart';

class UserSearchScreenArguments {
  late final String? mood;
  final DateTime? from;
  final DateTime? until;
  late final String? anonName;

  UserSearchScreenArguments(this.mood, this.from, this.until, this.anonName);
}

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final moods = [
    'Enjoyment\u{1F60A}',
    'Sadness\u{1F62D}',
    'Anger\u{1F621}',
    'Disgust\u{1F616}',
    'Fear\u{1F628}',
  ];

  DateTimeRange? dateRange;
  final TextEditingController anonNameController = TextEditingController();
  String? searchedmood;
  String? searchedanon;
  getFrom() {
    if (dateRange == null) {
      return DateTime(DateTime.now().year - 5);
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange!.start);
    }
  }

  getUntil() {
    if (dateRange == null) {
      return DateTime(DateTime.now().year + 5);
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
              children: [
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                  child: TextFormField(
                    controller: anonNameController,
                    onChanged: (value) {
                      searchedanon = value;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(color: Colors.red),
                      hintText: 'Search an Anonymous Name',
                      floatingLabelStyle: GoogleFonts.alfaSlabOne(),
                      hintStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: CustomColors.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: '',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
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
                            const NormalTextWidget(
                                color: Colors.white,
                                fontSize: 18,
                                text: 'Date Range'

                                // dateRange == null
                                //     ? 'Date Range'
                                //     : '${getFrom().toString()} - ${getUntil().toString()}'

                                ),
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
                  height: 15,
                ),
                DropDownButtonFormFieldWidget(
                    enabled: true,
                    dropdownbackgroundcolor: CustomColors.primary,
                    dropdownIconcolor: Colors.white,
                    dropdownitemcolor: Colors.white,
                    padding: const EdgeInsets.fromLTRB(37, 12, 37, 0),
                    label: '',
                    value: mood,
                    hint: const Center(
                        child: NormalTextWidget(
                            color: Colors.white,
                            fontSize: 20,
                            text: 'Select Mood')),
                    onChanged: (newValue) {
                      setState(() {
                        mood = newValue;
                        searchedmood = newValue as String?;
                        // print(mood);
                        // print(mood.runtimeType);
                      });
                    },
                    items: moods.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        alignment: AlignmentDirectional.center,
                        value: value,
                        child: Center(child: Text(value)),
                      );
                    }).toList()),
                const SizedBox(
                  height: 250,
                ),
                ButtonWidget(
                    borderRadius: 20,
                    onPressed: () {
                      Navigation(context).goToFreedomPostsScreen(
                          mood: searchedmood,
                          from: dateRange?.start ??
                              DateTime(DateTime.now().year - 5),
                          until: dateRange?.end ??
                              DateTime(DateTime.now().year + 5),
                          anonName: searchedanon);
                    },
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
