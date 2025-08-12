class PaginatedLocations {
  final List<LocationModel> results;
  final int numberOfPages;

  PaginatedLocations({required this.results, required this.numberOfPages});

  factory PaginatedLocations.fromJson(Map<String, dynamic> json) {
    return PaginatedLocations(
      results: List.from(
        json['results'],
      ).map((element) => LocationModel.fromJson(element)).toList(),
      numberOfPages: json['info']['pages'],
    );
  }

  static PaginatedLocations parsePaginatedLocations(Map<String, dynamic> json) {
    return PaginatedLocations.fromJson(json);
  }
}

class LocationModel {
  final int id;
  final String name;
  final String type;
  final String dimension;

  LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension
  });

  static const String endPoint = '/location';

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      dimension: json['dimension']
    );
  }
}

enum LocationPropertyType { name, type, dimension }
