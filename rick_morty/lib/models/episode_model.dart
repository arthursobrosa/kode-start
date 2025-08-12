class PaginatedEpisodes {
  final List<EpisodeModel> results;
  final int numberOfPages;

  PaginatedEpisodes({required this.results, required this.numberOfPages});

  factory PaginatedEpisodes.fromJson(Map<String, dynamic> json) {
    return PaginatedEpisodes(
      results: List.from(
        json['results'],
      ).map((element) => EpisodeModel.fromJson(element)).toList(),
      numberOfPages: json['info']['pages'],
    );
  }

  static PaginatedEpisodes parsePaginatedEpisodes(Map<String, dynamic> json) {
    return PaginatedEpisodes.fromJson(json);
  }
}

class EpisodeModel {
  final int id;
  final String name;
  final String episodeCode;

  EpisodeModel({required this.id, required this.name, required this.episodeCode});

  static const String endPoint = '/episode';

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'], 
      name: json['name'],
      episodeCode: json['episode']
    );
  }
}

enum EpisodePropertyType { name, episode }