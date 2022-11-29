import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/screens/ceosi_company_app/widgets/drawer_widget.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime focusedDay = DateTime.now();
  late DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: CustomColors.greyAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const BoldTextWidget(
                    color: Colors.black, fontSize: 23, text: 'Event Calendar'),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: TableCalendar(
                    firstDay: DateTime(2022),
                    lastDay: DateTime(2024),
                    focusedDay: focusedDay,
                    calendarFormat: _calendarFormat,
                    calendarStyle: const CalendarStyle(
                        weekendTextStyle:
                            TextStyle(color: CustomColors.secondary)),
                    headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: CustomColors.primary)),
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay = focusDay;
                      });
                      print(focusedDay);
                    },
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.secondary,
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/addannouncementscreen',
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
