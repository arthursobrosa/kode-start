import 'package:flutter/material.dart';
import 'package:rick_morty/data/repository.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/models/episode_model.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/widgets/app_bar_widget.dart';
import 'package:rick_morty/widgets/detailed_card_widget.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/details';
  const DetailsPage({
    super.key,
    required this.characterId,
    required this.episodeId,
  });

  final int characterId;
  final int? episodeId;

  @override
  State<DetailsPage> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  late Future<List<dynamic>> combinedFuture;

  @override
  void initState() {
    final characterFuture = Repository.getCharacter(widget.characterId);

    final episodeFuture = widget.episodeId != null
        ? Repository.getEpisode(widget.episodeId!)
        : Future.value(null);

    combinedFuture = Future.wait([characterFuture, episodeFuture]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarWidget(
        isDetailsPage: true,
        onTapLeftIcon: () {
          Navigator.pop(context);
        },
      ),
      body: FutureBuilder(
        future: combinedFuture,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final character = snapshot.data![0] as CharacterModel;
            final episode = snapshot.data![1] as EpisodeModel?;

            return DetailedCardWidget(
              character: character, 
              episode: episode
            );
          } else {
            return Center(child: Text('Nenhum dado encontrado'));
          }
        },
      ),
    );
  }
}
