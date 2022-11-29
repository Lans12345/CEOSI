import 'package:ceosi_app/screens/ceosi_rewards/widgets/search_delegate/search_delegate_item_widget.dart';
import 'package:ceosi_app/screens/ceosi_rewards/widgets/search_delegate/search_delegate_user_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import 'buttons/dropdown_item_widget.dart';

class SearchUserWidget extends StatefulWidget {
  const SearchUserWidget({super.key});

  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState();
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  int _dropdownValue = 0;

  String itemCategory = 'Flutter Developers';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: SearchDelegateUser());
        },
        child: Container(
          height: 35,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(100)),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.search,
                color: CustomColors.primary,
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: 180,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: DropdownButton(
                    underline: Container(color: Colors.transparent),
                    iconEnabledColor: Colors.black,
                    isExpanded: true,
                    value: _dropdownValue,
                    items: [
                      DropdownMenuItem(
                        onTap: () {
                          itemCategory = 'Flutter Developers';
                        },
                        value: 0,
                        child: DropDownItem(label: 'Flutter Developers'),
                      ),
                      DropdownMenuItem(
                        onTap: () {
                          itemCategory = 'Front End Developers';
                        },
                        value: 1,
                        child: DropDownItem(label: 'Frontend Developers'),
                      ),
                      DropdownMenuItem(
                        onTap: () {
                          itemCategory = 'Backend Developers';
                        },
                        value: 2,
                        child: DropDownItem(label: 'Backend Developers'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _dropdownValue = int.parse(value.toString());
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchItemWidget extends StatefulWidget {
  const SearchItemWidget({super.key});

  @override
  State<SearchItemWidget> createState() => _SearchItemWidgetState();
}

class _SearchItemWidgetState extends State<SearchItemWidget> {
  int _dropdownValue = 0;

  String itemCategory = 'Snacks';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: SearchDelegateProduct());
        },
        child: Container(
          height: 35,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(100)),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.search,
                color: CustomColors.primary,
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: 120,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: DropdownButton(
                    underline: Container(color: Colors.transparent),
                    iconEnabledColor: Colors.black,
                    isExpanded: true,
                    value: _dropdownValue,
                    items: [
                      DropdownMenuItem(
                        onTap: () {
                          itemCategory = 'Snacks';
                        },
                        value: 0,
                        child: DropDownItem(label: 'Snacks'),
                      ),
                      DropdownMenuItem(
                        onTap: () {
                          itemCategory = 'Drinks';
                        },
                        value: 1,
                        child: DropDownItem(label: 'Drinks'),
                      ),
                      DropdownMenuItem(
                        onTap: () {
                          itemCategory = 'Candies';
                        },
                        value: 2,
                        child: DropDownItem(label: 'Candies'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _dropdownValue = int.parse(value.toString());
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
