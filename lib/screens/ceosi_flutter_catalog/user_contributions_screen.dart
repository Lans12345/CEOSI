import 'package:ceosi_app/models/ceosi_flutter_catalog/user_contributions_model.dart';
import 'package:ceosi_app/providers/ceosi_flutter_catalog/user_contributions_provider.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/catalog_entries_screen.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/appbar_extension_widget.dart';
import 'package:ceosi_app/screens/ceosi_flutter_catalog/widgets/flutter_catalog_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/colors.dart';
import '../../constants/labels.dart';
import '../../widgets/text_widget.dart';

class UserContributionsScreen extends StatelessWidget {
  const UserContributionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: flutterCatalogAppbarWidget(title: Labels.userContributions),
      body: Column(
        children: [
          const AppbarExtensionWidget(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                UserContributionsViewWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserContributionsViewWidget extends ConsumerWidget {
  const UserContributionsViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<UserContributionsModel?> contributionData =
        ref.watch(userContributionsStateNotifierProvider);
    return contributionData.when(
      data: (data) {
        List<ContributionDatumModel> contributionDetails =
            data!.contributionData;
        return UserContributionWidget(contributionDetails);
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(
          child: CircularProgressIndicator(
        color: CustomColors.primary,
      )),
    );
  }
}

class UserContributionWidget extends StatelessWidget {
  const UserContributionWidget(this.contributionDetails, {super.key});
  final List<ContributionDatumModel> contributionDetails;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: contributionDetails[0].contributions.length,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(20.0),
            splashColor: Colors.transparent,
            onTap: () => navigateToSourceCodeScreen(
                navigator,
                contributionDetails[0].contributions[index].title.toUpperCase(),
                index,
                'user-contributions'),
            // onTap: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 20.0, 36.0, 20.0),
              child: Container(
                height: 120.0,
                decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? CustomColors.primary
                        : CustomColors.secondary,
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
                          fontSize: 12.0,
                          text:
                              contributionDetails[0].contributions[index].title,
                        ),
                      ],
                    ),
                    BoldTextWidget(
                      color: Colors.white,
                      fontSize: 10.0,
                      text:
                          contributionDetails[0].contributions[index].category,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
