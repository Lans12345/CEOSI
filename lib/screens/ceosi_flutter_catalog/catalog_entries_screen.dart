import 'package:ceosi_app/constants/colors.dart';
import 'package:ceosi_app/models/ceosi_flutter_catalog/catalog_entries_model.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/appbar_extension_widget.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/confirmation_dialog.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/flutter_catalog_appbar_widget.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/flutter_catalog_navigation_column_widget.dart';
import 'package:ceosi_app/services/navigation.dart';
import 'package:ceosi_app/widgets/sidebar_widget.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../constants/labels.dart';
import '../../constants/routes.dart';

class CatalogEntriesScreen extends StatelessWidget {
  const CatalogEntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => ConfirmationDialog(context).dialog(
        title: Labels.goToHomeScreenConfirmationTitle,
        onPressed: () => Navigation(context).goToHomeScreen(),
      ),
      child: Scaffold(
        appBar: flutterCatalogAppbarWidget(title: Labels.catalogEntries),
        drawer: const SidebarWidget(
          navigationColumn: FlutterCatalogNavigationColumnWidget(),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 5.0, right: 5.0),
          child: FloatingActionButton(
            tooltip: Labels.addEntry,
            backgroundColor: Colors.white,
            elevation: 5,
            splashColor: CustomColors.greyAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: const Icon(
              Icons.add_rounded,
              color: CustomColors.primary,
              size: 35.0,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(Routes.addcatalogentryscreen),
          ),
        ),
        body: Column(
          children: [
            const AppbarExtensionWidget(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CatalogEntriesViewWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SourceCodeArguments {
  SourceCodeArguments(this.title, this.index, this.screen);

  final String title;
  final int index;
  final String screen;
}

navigateToSourceCodeScreen(
    NavigatorState navigator, String title, int index, String fromScreen) {
  navigator.pushNamed(
    Routes.sourcecodescreen,
    arguments: SourceCodeArguments(title, index, fromScreen),
  );
}

class CatalogEntriesViewWidget extends ConsumerWidget {
  const CatalogEntriesViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CatalogEntryWidget();
  }
}

class CatalogEntryWidget extends StatefulWidget {
  const CatalogEntryWidget({super.key});

  @override
  State<CatalogEntryWidget> createState() => _CatalogEntryWidgetState();
}

class _CatalogEntryWidgetState extends State<CatalogEntryWidget> {
  final queryCatalogEntries = FirebaseFirestore.instance
      .collection('CEOSI-FLUTTERCATALOG-CATALOG-ENTRIES')
      .withConverter<CatalogEntriesModel>(
        fromFirestore: (snapshot, _) =>
            CatalogEntriesModel.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Expanded(
      child: FirestoreQueryBuilder<CatalogEntriesModel>(
        pageSize: 10,
        query: queryCatalogEntries,
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return const Center(
                child: CircularProgressIndicator(color: CustomColors.primary));
          } else if (snapshot.hasError) {
            return Text('${Labels.somethingWentWrong} ${snapshot.error}');
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              final hasReachedEnd = snapshot.hasMore &&
                  index + 1 == snapshot.docs.length &&
                  !snapshot.isFetchingMore;
              if (hasReachedEnd) {
                snapshot.fetchMore();
              }

              final entry = snapshot.docs[index].data();

              return InkWell(
                borderRadius: BorderRadius.circular(20.0),
                splashColor: Colors.transparent,
                onTap: () => navigateToSourceCodeScreen(navigator,
                    entry.title.toUpperCase(), index, 'catalog-entries'),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(36.0, 20.0, 36.0, 20.0),
                  child: Container(
                    height: 120.0,
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? CustomColors.secondary
                            : CustomColors.primary,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/code.png',
                              scale: 25.0,
                            ),
                            const SizedBox(width: 5.0),
                            BoldTextWidget(
                              color: Colors.white,
                              fontSize: 16.0,
                              text: entry.title,
                            ),
                          ],
                        ),
                        NormalTextWidget(
                          color: Colors.white,
                          fontSize: 12.0,
                          text: entry.category,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
