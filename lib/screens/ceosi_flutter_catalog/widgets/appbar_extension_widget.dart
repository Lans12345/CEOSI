import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/category_listview_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class AppbarExtensionWidget extends StatelessWidget {
  const AppbarExtensionWidget({super.key});

  void showCategoryFilter(context) {
    showModalBottomSheet(
      backgroundColor: CustomColors.darkGrey,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      )),
      isScrollControlled: true,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 2 / 4),
      context: context,
      builder: (context) {
        return const CategoryListViewWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CustomColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          bottom: 20.0,
        ),
        child: Row(
          children: <Widget>[
            CatalogEntriesSearchFieldWidget(),
            IconButton(
              onPressed: () => showCategoryFilter(context),
              icon: const Icon(
                Icons.filter_list,
                size: 24.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CatalogEntriesSearchFieldWidget extends StatelessWidget {
  CatalogEntriesSearchFieldWidget({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: searchController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
            isDense: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: CustomColors.primary,
                ))),
      ),
    );
  }
}
