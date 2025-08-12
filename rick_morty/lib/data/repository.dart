import 'package:dio/dio.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/models/episode_model.dart';

abstract class Repository {
  static final _dio = Dio(
    BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'),
  );

  static Future<PaginatedCharacters> getPaginatedCharacters({
    required int page,
    required (String, dynamic)? property,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['page'] = page;

    if (property != null) {
      queryParameters[property.$1] = property.$2;
    }

    var response = await _dio.get(
      '/character',
      queryParameters: queryParameters,
    );

    return PaginatedCharacters.fromJson(response.data);
  }

  static Future<CharacterModel> getCharacter(int characterId) async {
    var response = await _dio.get('/character/$characterId');
    return CharacterModel.fromJson(response.data);
  }

  static Future<EpisodeModel> getEpisode(int episodeId) async {
    var response = await _dio.get('/episode/$episodeId');
    return EpisodeModel.fromJson(response.data);
  }

  static Future<CharacterModel> getCharacterWithEpisode(
    CharacterModel character,
  ) async {
    int? episodeId = character.firstEpisodeId;
    String firstSeenIn = 'Unknown';

    if (episodeId != null) {
      EpisodeModel episode = await getEpisode(episodeId);
      firstSeenIn = episode.name;
    }

    character.firstSeenIn = firstSeenIn;

    return character;
  }
}
