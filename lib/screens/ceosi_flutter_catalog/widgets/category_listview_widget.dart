import 'package:ceosi_app/models/ceosi_flutter_catalog/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/colors.dart';
import '../../../constants/labels.dart';
import '../../../providers/ceosi_flutter_catalog/category_list_provider.dart';
import '../../../widgets/text_widget.dart';

class CategoryListViewWidget extends ConsumerWidget {
  const CategoryListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<CategoryModel?> categoryListData =
        ref.watch(categoryListStateNotifierProvider);
    return categoryListData.when(
      data: (data) {
        List<CategoryItem> categoryList = data!.categoryList;
        return CategoryListItemWidget(categoryList);
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      )),
    );
  }
}

class CategoryListItemWidget extends StatelessWidget {
  const CategoryListItemWidget(this.categoryItem, {super.key});
  final List<CategoryItem> categoryItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              BoldTextWidget(
                color: Colors.white,
                fontSize: 16.0,
                text: Labels.categories,
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: categoryItem.length,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  splashColor: Colors.transparent,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(36.0, 10.0, 36.0, 10.0),
                    child: Container(
                      height: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/category.png',
                                scale: 25.0,
                                color: CustomColors.primary,
                              ),
                              const SizedBox(width: 5.0),
                              BoldTextWidget(
                                color: CustomColors.primary,
                                fontSize: 12.0,
                                text:
                                    '${categoryItem[index].title} (${categoryItem[index].items})',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
