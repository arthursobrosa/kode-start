class EpisodeModel {
  final int id;
  final String name;

  EpisodeModel({required this.id, required this.name});

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(id: json['id'], name: json['name']);
  }
}
