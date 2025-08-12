class PaginatedCharacters {
  final List<CharacterModel> results;

  PaginatedCharacters({required this.results});

  factory PaginatedCharacters.fromJson(Map<String, dynamic> json) {
    return PaginatedCharacters(
      results: List.from(
        json['results'],
      ).map((element) => CharacterModel.fromJson(element)).toList(),
    );
  }
}

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String imagePath;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.imagePath,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      imagePath: json['image'],
    );
  }
}
