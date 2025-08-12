import 'package:flutter/foundation.dart';
import 'package:rick_morty/data/repository.dart';
import 'package:rick_morty/models/character_model.dart';

class HomeData {
  List<CharacterModel> characters;
  bool isLoading;
  bool isConnecting;
  bool isShowingError;
  int selectedDrawerIndex;

  HomeData({
    required this.characters,
    required this.isLoading,
    required this.isConnecting,
    required this.isShowingError,
    required this.selectedDrawerIndex,
  });

  HomeData copyWith({
    List<CharacterModel>? characters,
    bool? isLoading,
    bool? isConnecting,
    bool? isShowingError,
    int? selectedDrawerIndex,
  }) {
    return HomeData(
      characters: characters ?? this.characters,
      isLoading: isLoading ?? this.isLoading,
      isConnecting: isConnecting ?? this.isConnecting,
      isShowingError: isShowingError ?? this.isShowingError,
      selectedDrawerIndex: selectedDrawerIndex ?? this.selectedDrawerIndex,
    );
  }
}

class HomeViewModel {
  ValueNotifier<HomeData> homeData = ValueNotifier(
    HomeData(
      characters: [],
      isLoading: false,
      isConnecting: true,
      isShowingError: false,
      selectedDrawerIndex: 0,
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
      await fetchCharacters();
    } on ApiException {
      rethrow;
    }
  }

  Future<void> setNumberOfPages() async {
    try {
      final paginatedCharacters = await Repository.fetchEntity(
        CharacterModel.endPoint,
        (json) => PaginatedCharacters.fromJson(json),
        page: 1,
        property: _queryParameterTuple,
      );

      _numberOfPages = paginatedCharacters.numberOfPages;
    } on ApiException {
      rethrow;
    }
  }

  Future<void> fetchCharacters() async {
    if (_page > _numberOfPages) {
      homeData.value = homeData.value.copyWith(isLoading: false);
      return;
    }

    if (homeData.value.isLoading) return;

    homeData.value = homeData.value.copyWith(isLoading: true);

    try {
      final paginatedCharacters = await Repository.fetchEntity(
        CharacterModel.endPoint,
        (json) => PaginatedCharacters.fromJson(json),
        page: _page,
        property: _queryParameterTuple,
      );

      final updatedCharacters = List<CharacterModel>.from(
        homeData.value.characters,
      )..addAll(paginatedCharacters.results);

      _page++;

      homeData.value = homeData.value.copyWith(
        characters: updatedCharacters,
        isLoading: false,
      );
    } on ApiException {
      rethrow;
    }
  }

  void resetHomeData() {
    homeData.value = homeData.value.copyWith(
      characters: [],
      isLoading: false,
      isConnecting: true,
      isShowingError: false,
    );

    _page = 1;
  }

  void updateQuery({
    required String selectedFilter,
    required String textFieldText,
  }) {
    _queryParameterTuple = (selectedFilter, textFieldText);
  }

  String? getEmptyText({required String selectedFilter}) {
    if (_error?.statusCode == 404) {
      return 'No character found with that $selectedFilter';
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
    homeData.value = homeData.value.copyWith(selectedDrawerIndex: index);
  }
}
