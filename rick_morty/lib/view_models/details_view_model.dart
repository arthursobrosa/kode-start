import 'package:flutter/foundation.dart';
import 'package:rick_morty/data/repository.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/models/episode_model.dart';

class DetailsData {
  EpisodeModel? episode;
  bool isLoading;

  DetailsData({required this.episode, required this.isLoading});

  DetailsData copyWith({EpisodeModel? episode, bool? isLoading}) {
    return DetailsData(
      episode: episode ?? this.episode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class DetailsViewModel {
  ValueNotifier<DetailsData> detailsData = ValueNotifier(
    DetailsData(episode: null, isLoading: false),
  );

  final CharacterModel character;

  DetailsViewModel({required this.character});

  Future<void> fetchEpisode() async {
    detailsData.value = detailsData.value.copyWith(isLoading: true);

    int? firstEpisodeId = character.firstEpisodeId;

    if (firstEpisodeId != null) {
      try {
        final fetchedEpisode = await Repository.fetchEntity(
          '${EpisodeModel.endPoint}/$firstEpisodeId',
          (json) => EpisodeModel.fromJson(json),
        );

        detailsData.value = detailsData.value.copyWith(episode: fetchedEpisode);
      } on ApiException catch (error) {
        // ignore: avoid_print
        print(error);
      }
    }

    detailsData.value = detailsData.value.copyWith(isLoading: false);
  }
}