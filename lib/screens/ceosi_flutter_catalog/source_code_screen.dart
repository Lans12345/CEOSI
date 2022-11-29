import 'package:ceosi_app/models/ceosi_flutter_catalog/catalog_entry_model.dart';
import 'package:ceosi_app/models/ceosi_flutter_catalog/user_contributions_model.dart';
import 'package:ceosi_app/providers/ceosi_flutter_catalog/catalog_entry_provider.dart';
import 'package:ceosi_app/providers/ceosi_flutter_catalog/user_contributions_provider.dart';
import 'package:ceosi_app/widgets/error_builder_widget.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/flutter_catalog_appbar_widget.dart';
import 'package:ceosi_app/widgets/sidebar_navigation_column_widget.dart';
import 'package:ceosi_app/widgets/text_widget.dart';
import 'package:code_editor/code_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/colors.dart';
import '../../constants/labels.dart';
import '../../constants/routes.dart';
import '../../services/navigation.dart';
import '../../widgets/sidebar_widget.dart';
import 'catalog_entries_screen.dart';

class SourceCodeScreen extends StatelessWidget {
  const SourceCodeScreen({super.key});

  _share(String body, String subject) async {
    await Share.share(
      body
          .replaceAll(RegExp('``````dart'), '')
          .replaceAll(RegExp('``````'), '')
          .trim(),
      subject: subject,
    );
  }

  _preview(context, dataList, args) {
    showDialog(
      barrierColor: CustomColors.primary,
      context: context,
      builder: (context) {
        return Image.network(
          dataList[args.index].previewUrl,
          loadingBuilder: (context, child, loadingProgress) {
            return loadingProgress != null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.primary,
                    ),
                  )
                : child;
          },
          errorBuilder: (context, error, stackTrace) {
            return const ErrorBuilderWidget(
              label: Labels.checkYourInternetConnectivity,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SourceCodeArguments;
    List<dynamic> dataList = [];
    String itemData = '';
    String itemTitle = '';
    String screen = args.screen;

    return Scaffold(
      appBar: flutterCatalogAppbarWidget(
        title: args.title,
      ),
      drawer: const SidebarWidget(
          navigationColumn: SidebarNavigationColumnWidget()),
      body: Consumer(
        builder: (context, ref, child) {
          AsyncValue<CatalogEntryModel?> entryData =
              ref.watch(catalogEntryStateNotifierProvider);
          AsyncValue<UserContributionsModel?> contributionData =
              ref.watch(userContributionsStateNotifierProvider);

          if (screen == 'catalog-entries') {
            return entryData.when(
              data: (data) {
                dataList = data!.entryData;
                itemData = dataList[args.index].data;
                itemTitle = dataList[args.index].title;
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      DescriptionWidget(
                        padding:
                            const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                        text: dataList[args.index].description,
                      ),
                      DataViewWidget(
                        isCode: dataList[args.index].isCode,
                        data: itemData,
                      ),
                      const SizedBox(height: 50.0),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const Center(
                  child: CircularProgressIndicator(
                color: CustomColors.primary,
              )),
            );
          } else if (screen == 'user-contributions') {
            return contributionData.when(
              data: (data) {
                //Data will be added on Firebase implementation
                return Container();
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const Center(
                  child: CircularProgressIndicator(
                color: CustomColors.primary,
              )),
            );
          }
          return Container();
        },
      ),
      bottomSheet: BottomSheetWidget(
        content: [
          BottomSheetButtonWidget(
              onPressed: () => _share(itemData, itemTitle),
              icon: Icons.share,
              label: Labels.share),
          const SizedBox(width: 20.0),
          BottomSheetButtonWidget(
              onPressed: () => _preview(context, dataList, args),
              icon: Icons.preview,
              label: Labels.preview),

          //show edit button when author (id) == current user (id)
          'CEOSI2022' == 'CEOSI2022'
              ? Row(
                  children: [
                    const SizedBox(width: 20.0),
                    BottomSheetButtonWidget(
                      onPressed: () {
                        Navigation(context)
                            .goToEditCatalogEntryScreen(args.title);
                      },
                      icon: Icons.edit,
                      label: 'Edit',
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}

class EditCatalogEntryArguments {
  EditCatalogEntryArguments(this.title);

  final String title;
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.padding,
    required this.text,
  });

  final EdgeInsetsGeometry padding;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RichText(
          overflow: TextOverflow.clip,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          softWrap: true,
          text: TextSpan(
            text: text,
            style: GoogleFonts.aleo(
                color: Colors.black, fontSize: 12.0, height: 1.5),
          )),
    );
  }
}

class DataViewWidget extends StatelessWidget {
  const DataViewWidget({
    super.key,
    required this.isCode,
    required this.data,
    this.backgroundColor = CustomColors.greyAccent,
    this.radius = 20.0,
  });

  final bool isCode;
  final String data;
  final Color backgroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final List<FileEditor> files = [
      FileEditor(
        name: 'code.dart',
        language: 'dart',
        code: <String>[data].join('\n'),
      ),
    ];

    EditorModel editorModel = EditorModel(
      files: files,
      styleOptions: EditorModelStyleOptions(
        fontSize: 10.0,
        toolbarOptions: const ToolbarOptions(
          copy: true,
          selectAll: true,
        ),
      ),
    );

    return isCode
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CodeEditor(
                    model: editorModel,
                    edit: false,
                    disableNavigationbar: true,
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 150.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                data,
                loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress != null
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: CustomColors.primary,
                          ),
                        )
                      : child;
                },
                errorBuilder: (context, error, stackTrace) {
                  return const ErrorBuilderWidget(
                    label: Labels.checkYourInternetConnectivity,
                    style: TextStyle(
                        color: CustomColors.secondary,
                        fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
          );
  }
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key, required this.content});

  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: CustomColors.primary,
      elevation: 2,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      )),
      onClosing: () {},
      builder: (context) {
        return SizedBox(
          height: 150.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: content,
          ),
        );
      },
    );
  }
}

class BottomSheetButtonWidget extends StatelessWidget {
  const BottomSheetButtonWidget(
      {super.key,
      required this.onPressed,
      required this.icon,
      this.label = ''});

  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          iconSize: 50.0,
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white, size: 50.0),
        ),
        BoldTextWidget(color: Colors.white, fontSize: 14.0, text: label),
      ],
    );
  }
}
