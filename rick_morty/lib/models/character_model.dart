class PaginatedCharacters {
  final List<CharacterModel> results;
  final int numberOfPages;

  PaginatedCharacters({required this.results, required this.numberOfPages});

  factory PaginatedCharacters.fromJson(Map<String, dynamic> json) {
    return PaginatedCharacters(
      results: List.from(
        json['results'],
      ).map((element) => CharacterModel.fromJson(element)).toList(),
      numberOfPages: json['info']['pages'],
    );
  }
}

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String origin;
  final String lastKnownLocation;
  final int? firstEpisodeId;
  final String imagePath;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.origin,
    required this.lastKnownLocation,
    required this.firstEpisodeId,
    required this.imagePath,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    List<String> episodeUrls = List.from(
      json['episode'],
    ).map((element) => element.toString()).toList();

    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      origin: json['origin']['name'],
      lastKnownLocation: json['location']['name'],
      firstEpisodeId: CharacterModel.getFirstEpisodeId(episodeUrls),
      imagePath: json['image'],
    );
  }

  static int? getFirstEpisodeId(List<String> episodeUrls) {
    if (episodeUrls.isEmpty) {
      return null;
    }

    String firstEpisodeUrl = episodeUrls.first;

    List<String> urlParts = firstEpisodeUrl.split('/');
    String episodeIdString = urlParts.last;

    return int.tryParse(episodeIdString);
  }
}

enum CharacterPropertyType {
  name,
  status,
  species,
  gender
}

extension CharacterPropertyTypeExtension on CharacterPropertyType {
  String get queryParameterName {
    switch (this) {
      case CharacterPropertyType.name:
        return 'name';
      case CharacterPropertyType.status:
        return 'status';
      case CharacterPropertyType.species:
        return 'species';
      case CharacterPropertyType.gender:
        return 'gender';
    }
  }
}