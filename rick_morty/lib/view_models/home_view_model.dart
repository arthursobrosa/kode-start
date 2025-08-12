import 'package:flutter/foundation.dart';
import 'package:rick_morty/service/api_service.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/models/episode_model.dart';
import 'package:rick_morty/models/location_model.dart';

class HomeData {
  List<dynamic> entities;
  bool isLoading;
  bool isConnecting;
  bool isShowingError;
  int selectedDrawerIndex;
  DrawerOptionType drawerOptionType;
  List<String> filters;
  String selectedFilter;

  HomeData({
    required this.entities,
    required this.isLoading,
    required this.isConnecting,
    required this.isShowingError,
    required this.selectedDrawerIndex,
    required this.drawerOptionType,
    required this.filters,
    required this.selectedFilter,
  });

  HomeData copyWith({
    List<dynamic>? entities,
    bool? isLoading,
    bool? isConnecting,
    bool? isShowingError,
    int? selectedDrawerIndex,
    DrawerOptionType? drawerOptionType,
    List<String>? filters,
    String? selectedFilter,
  }) {
    return HomeData(
      entities: entities ?? this.entities,
      isLoading: isLoading ?? this.isLoading,
      isConnecting: isConnecting ?? this.isConnecting,
      isShowingError: isShowingError ?? this.isShowingError,
      selectedDrawerIndex: selectedDrawerIndex ?? this.selectedDrawerIndex,
      drawerOptionType: drawerOptionType ?? this.drawerOptionType,
      filters: filters ?? this.filters,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

class HomeViewModel {
  ValueNotifier<HomeData> homeData = ValueNotifier(
    HomeData(
      entities: [],
      isLoading: false,
      isConnecting: true,
      isShowingError: false,
      selectedDrawerIndex: 0,
      drawerOptionType: DrawerOptionType.characters,
      filters: DrawerOptionType.characters.filters,
      selectedFilter: DrawerOptionType.characters.filters.first,
    ),
  );

  (String, dynamic)? _queryParameterTuple;
  int _numberOfPages = 0;
  int _page = 1;
  ApiException? _error;

  List<String> drawerOptions = ['Characters', 'Episodes', 'Locations'];

  Future<void> fetch() async {
    try {
      await setNumberOfPages();
      await fetchEntities();
    } on ApiException {
      rethrow;
    }
  }

  Future<void> setNumberOfPages() async {
    try {
      final paginatedEntities = await ApiService.fetchEntity(
        homeData.value.drawerOptionType.endPoint,
        homeData.value.drawerOptionType.parseMethod,
        page: 1,
        property: _queryParameterTuple,
      );

      _numberOfPages = paginatedEntities.numberOfPages;
    } on ApiException {
      rethrow;
    }
  }

  Future<void> fetchEntities() async {
    if (_page > _numberOfPages) {
      homeData.value = homeData.value.copyWith(isLoading: false);
      return;
    }

    if (homeData.value.isLoading) return;

    homeData.value = homeData.value.copyWith(isLoading: true);

    try {
      final paginatedEntities = await ApiService.fetchEntity(
        homeData.value.drawerOptionType.endPoint,
        homeData.value.drawerOptionType.parseMethod,
        page: _page,
        property: _queryParameterTuple,
      );

      final updatedEntities = List<dynamic>.from(homeData.value.entities)
        ..addAll(paginatedEntities.results);

      _page++;

      homeData.value = homeData.value.copyWith(
        entities: updatedEntities,
        isLoading: false,
      );
    } on ApiException {
      rethrow;
    }
  }

  void resetHomeData() {
    homeData.value = homeData.value.copyWith(
      entities: [],
      isLoading: false,
      isConnecting: true,
      isShowingError: false,
    );

    _page = 1;
  }

  void updateQuery({required String textFieldText}) {
    final selectedFilter = homeData.value.selectedFilter;
    _queryParameterTuple = (selectedFilter, textFieldText);
  }

  String? getEmptyText() {
    final selectedFilter = homeData.value.selectedFilter;
    final entity = homeData.value.drawerOptionType.singleName;

    if (_error?.statusCode == 404) {
      return 'No $entity found with that $selectedFilter';
    }

    return _error?.message;
  }

  void setError(ApiException error) {
    _error = error;
    homeData.value = homeData.value.copyWith(isShowingError: true);
    _queryParameterTuple = null;
  }

  void changeConnection({required bool isConnecting}) {
    homeData.value = homeData.value.copyWith(isConnecting: isConnecting);
  }

  void updateSelectedDrawer(int index) {
    resetHomeData();

    late DrawerOptionType newDrawerOptionType;

    switch (index) {
      case 0:
        newDrawerOptionType = DrawerOptionType.characters;
      case 1:
        newDrawerOptionType = DrawerOptionType.episodes;
      case 2:
        newDrawerOptionType = DrawerOptionType.locations;
    }

    homeData.value = homeData.value.copyWith(
      selectedDrawerIndex: index,
      drawerOptionType: newDrawerOptionType,
      filters: newDrawerOptionType.filters,
      selectedFilter: newDrawerOptionType.filters.first,
    );
  }

  void updateSelectedFilter(String filter) {
    homeData.value = homeData.value.copyWith(selectedFilter: filter);
  }
}

enum DrawerOptionType { characters, episodes, locations }

typedef FromJson<T> = T Function(Map<String, dynamic> json);

extension DrawerOptionTypeProperties on DrawerOptionType {
  String get endPoint {
    switch (this) {
      case DrawerOptionType.characters:
        return CharacterModel.endPoint;
      case DrawerOptionType.episodes:
        return EpisodeModel.endPoint;
      case DrawerOptionType.locations:
        return LocationModel.endPoint;
    }
  }

  FromJson<dynamic> get parseMethod {
    switch (this) {
      case DrawerOptionType.characters:
        return PaginatedCharacters.parsePaginatedCharacters;
      case DrawerOptionType.episodes:
        return PaginatedEpisodes.parsePaginatedEpisodes;
      case DrawerOptionType.locations:
        return PaginatedLocations.parsePaginatedLocations;
    }
  }

  String get singleName {
    switch (this) {
      case DrawerOptionType.characters:
        return 'character';
      case DrawerOptionType.episodes:
        return 'episode';
      case DrawerOptionType.locations:
        return 'location';
    }
  }

  List<String> get filters {
    switch (this) {
      case DrawerOptionType.characters:
        return CharacterPropertyType.values
            .map((element) => element.name)
            .toList();
      case DrawerOptionType.episodes:
        return EpisodePropertyType.values
            .map((element) => element.name)
            .toList();
      case DrawerOptionType.locations:
        return LocationPropertyType.values
            .map((element) => element.name)
            .toList();
    }
  }
}
