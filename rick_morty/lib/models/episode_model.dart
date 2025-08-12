class EpisodeModel {
  final int id;
  final String name;

  EpisodeModel({required this.id, required this.name});

  static const String endPoint = '/episode';

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(id: json['id'], name: json['name']);
  }
}
