import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/data/repository.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/models/episode_model.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/widgets/shimmer_widget.dart';
import 'package:rick_morty/widgets/sliver_app_bar_widget.dart';
import 'package:rick_morty/widgets/detailed_card_widget.dart';
import 'package:rick_morty/widgets/app_title_widget.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/details';

  const DetailsPage({super.key, required this.character});

  final CharacterModel character;

  @override
  State<DetailsPage> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  late Future<EpisodeModel?> episodeFuture;

  @override
  void initState() {
    int? firstEpisodeId = widget.character.firstEpisodeId;
    episodeFuture = firstEpisodeId != null
        ? Repository.getEpisode(firstEpisodeId)
        : Future.value(null);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              )
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: IconButton(
                  onPressed: () => Void,
                  icon: Icon(
                    CupertinoIcons.person_crop_circle,
                    color: AppColors.rightIconColor,
                    size: 24,
                  ),
                ),
              ),
            ],
            titleWidget: AppTitleWidget(),
          ),

          SliverToBoxAdapter(
            child: FutureBuilder(
              future: episodeFuture, 
              builder: (context, AsyncSnapshot<EpisodeModel?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.only(top: 17, left: 20, right: 20),
                    child: ShimmerWidget.rectangular(height: 500, borderRadius: 10),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final episode = snapshot.data! as EpisodeModel?;
                  return DetailedCardWidget(character: widget.character, episode: episode);
                } else {
                  return Center(child: Text('Nenhum dado encontrado'));
                }
              }
            ),
          )
        ],
      ),
    );
  }
}
