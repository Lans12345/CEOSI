import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/screens/ceosi_company_app/widgets/drawer_widget.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: CustomColors.greyAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(children: const [
              BoldTextWidget(
                  color: Colors.black, fontSize: 23, text: 'The Team'),
              FliterTeam(),
            ]),
            const SizedBox(
              height: 10,
            ),
            SearchTeam(searchController: searchController),
            const SizedBox(
              height: 20,
            ),
            const TeamList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.secondary,
        onPressed: () {
          Navigator.pushNamed(context, '/addteamscreen');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TeamList extends StatelessWidget {
  const TeamList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(children: [
            InkWell(
              onTap: (() {}),
              child: Stack(
                children: [
                  Card(
                      color: CustomColors.primary,
                      elevation: 3.0,
                      margin: const EdgeInsets.only(left: 45.0),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(width: 30),
                            TeamItem(),
                          ],
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: CircleAvatar(
                      backgroundColor: CustomColors.secondary,
                      radius: 45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ]);
        },
      ),
    );
  }
}

class TeamItem extends StatelessWidget {
  const TeamItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BoldTextWidget(
              color: Colors.white,
              fontSize: 14,
              text: 'Finina Chloie O. Biscocho'),
          SizedBox(height: 5),
          NormalTextWidget(
              color: Colors.white,
              fontSize: 12,
              text: 'Flutter Developer Trainee'),
          SizedBox(height: 5),
          NormalTextWidget(
              color: Colors.white,
              fontSize: 12,
              text: 'finina.ceosi@gmail.com'),
          SizedBox(height: 5),
          NormalTextWidget(
              color: Colors.white, fontSize: 12, text: 'March 17,1999')
        ],
      ),
    );
  }
}

class SearchTeam extends StatelessWidget {
  const SearchTeam({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(
            Icons.search,
            color: CustomColors.primary,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: CustomColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: CustomColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class FliterTeam extends StatelessWidget {
  const FliterTeam({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        padding: const EdgeInsets.only(left: 200),
        icon: const Icon(Icons.filter_list, color: Colors.black),
        itemBuilder: (ctx) => [
              PopupMenuItem(
                onTap: () {},
                child: const Text('Department'),
              ),
              PopupMenuItem(
                onTap: () {},
                child: const Text('Job Title'),
              ),
              PopupMenuItem(
                onTap: () {},
                child: const Text('Birth Date'),
              )
            ]);
  }
}
