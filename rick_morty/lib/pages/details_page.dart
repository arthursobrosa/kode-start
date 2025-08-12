import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/view_models/details_view_model.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/text_type.dart';
import 'package:rick_morty/widgets/drawer_widget.dart';
import 'package:rick_morty/widgets/settings_tile_widget.dart';
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
    return ValueListenableBuilder(
      valueListenable: _viewModel.detailsData,
      builder: (_, data, _) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor(context),
          endDrawer: DrawerWidget(
            backgroundColor: AppColors.secondaryColor(context),
            items: [
              SettingsTileWidget(
                textStyle: TextType.spacedTitle.textSyle(context)
              )
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBarWidget(
                backgroundColor: AppColors.secondaryColor(context),
                leftIcon: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.leftIconColor(context),
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
                          color: AppColors.rightIconColor(context),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ], 
                titleWidget: AppTitleWidget(
                  textStyle: TextType.spacedTitle.textSyle(context)
                )
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
                          baseColor: AppColors.baseShimmerColor(context),
                          highlightColor: AppColors.highlightShimmerColor(context),
                        ),
                      )
                    else
                      DetailedCharacterCardWidget(
                        circleStrokeColor: AppColors.labelColor(context),
                        character: _viewModel.character,
                        episode: data.episode,
                        keyWidgetTextStyle: TextType.bodySmall.textSyle(context),
                        valueWidgetTextStyle: TextType.bodyRegular.textSyle(context),
                        titleTextStyle: TextType.boldTitle.textSyle(context),
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