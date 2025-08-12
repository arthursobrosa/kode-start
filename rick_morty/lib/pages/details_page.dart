import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/view_models/details_view_model.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/text_type.dart';
import 'package:rick_morty/widgets/drawer_widget.dart';
import 'package:rick_morty/widgets/shimmer_widget.dart';
import 'package:rick_morty/widgets/sliver_app_bar_widget.dart';
import 'package:rick_morty/widgets/detailed_character_card_widget.dart';
import 'package:rick_morty/widgets/app_title_widget.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/details';

  const DetailsPage({super.key, required this.character});

  final CharacterModel character;

  @override
  State<DetailsPage> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  late final DetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = DetailsViewModel(character: widget.character);
    _viewModel.fetchEpisode();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DetailsData>(
      valueListenable: _viewModel.detailsData,
      builder: (_, data, _) {
        return Scaffold(
          endDrawer: DrawerWidget(
            items: [
              ListTile(
                title: Text('Item 1', style: TextType.appTitle.textSyle),
                onTap: () => Void,
              ),
            ],
          ),
          backgroundColor: AppColors.backgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBarWidget(
                leftIcon: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.leftIconColor,
                    size: 24,
                  ),
                ),
                actions: [
                  Builder(
                    builder: (context) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: IconButton(
                        onPressed: Scaffold.of(context).openEndDrawer,
                        icon: Icon(
                          CupertinoIcons.person_crop_circle,
                          color: AppColors.rightIconColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
                titleWidget: AppTitleWidget(),
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    if (data.isLoading)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 17,
                        ),
                        child: ShimmerWidget.rectangular(
                          height: 500,
                          borderRadius: 10,
                        ),
                      )
                    else
                      DetailedCharacterCardWidget(
                        character: _viewModel.character,
                        episode: data.episode,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
