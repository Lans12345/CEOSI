import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/services/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ceosi_app/widgets/sidebar_navigation_column_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/sidebar_widget.dart';
import '../../widgets/text_widget.dart';

class AdminPanelSearchScreenArguments {
  late final String? id;
  late final String? anonName;

  AdminPanelSearchScreenArguments(this.id, this.anonName);
}

class AdminPanelSearchScreen extends StatefulWidget {
  const AdminPanelSearchScreen({super.key});

  @override
  State<AdminPanelSearchScreen> createState() => _AdminPanelSearchScreenState();
}

class _AdminPanelSearchScreenState extends State<AdminPanelSearchScreen> {
  final TextEditingController anonNameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  String? searchedanon;
  String? searchedid;

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
                TextFormField(
                  controller: idController,
                  onChanged: (value) {
                    searchedid = value;
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.red),
                    hintText: 'Search ID',
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
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 250,
                ),
                ButtonWidget(
                    borderRadius: 20,
                    onPressed: () {
                      Navigation(context).goToAdminPostsDataScreen(
                          id: searchedid, anonName: searchedanon);
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
