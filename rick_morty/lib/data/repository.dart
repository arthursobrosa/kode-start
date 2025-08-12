import 'package:dio/dio.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/models/episode_model.dart';

abstract class Repository {
  static final _dio = Dio(
    BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'),
  );

  static Future<PaginatedCharacters> getPaginatedCharacters() async {
    var response = await _dio.get('/character');
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
}
