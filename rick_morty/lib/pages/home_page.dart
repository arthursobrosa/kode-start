import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/data/repository.dart';
import 'package:rick_morty/pages/details_page.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/widgets/empty_widget.dart';
import 'package:rick_morty/widgets/filters_widget.dart';
import 'package:rick_morty/widgets/sliver_app_bar_widget.dart';
import 'package:rick_morty/widgets/home_card_widget.dart';
import 'package:rick_morty/widgets/shimmer_widget.dart';
import 'package:rick_morty/widgets/app_title_widget.dart';
import 'package:rick_morty/widgets/text_field_widget.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CharacterModel> characters = [];
  bool isLoading = false;
  bool isConnecting = true;
  late int numberOfPages;
  int page = 1;
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarCollapsed = false;
  bool _isTextFieldShowing = false;
  String text = '';
  (String, dynamic)? queryParameterTuple;
  final TextEditingController _textEditingController = TextEditingController();
  List<String> filters = CharacterPropertyType.values
      .map((element) => element.name)
      .toList();
  late String selectedFilter;
  bool _isShowingError = false;
  ApiException? error;
  final FocusNode focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    selectedFilter = filters.first;

    fetch();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetch();
      }
    });

    _scrollController.addListener(() {
      double expandedHeight = SliverAppBarWidget.expandedHeight;
      double toolbarHeight = SliverAppBarWidget.toolbarHeight;

      bool isExpanded =
          _scrollController.hasClients &&
          _scrollController.offset < (expandedHeight - toolbarHeight);

      if (isExpanded == _isAppBarCollapsed) {
        setState(() {
          _isAppBarCollapsed = !isExpanded;

          if (!_isAppBarCollapsed && _isTextFieldShowing && text.isEmpty) {
            _isTextFieldShowing = false;
          }
        });
      }
    });

    super.initState();
  }

  Future<void> fetch() async {
    try {
      await setNumberOfPages();
      await fetchCharacters();
    } on ApiException catch (error) {
      if (kDebugMode) {
        print(error);
      }

      setState(() {
        this.error = error;
        _isShowingError = true;
        _isTextFieldShowing = false;
        _isAppBarCollapsed = false;
        text = '';
        _textEditingController.text = text;
        queryParameterTuple = null;
      });
    }

    setState(() {
      isConnecting = false;
    });
  }

  Future<void> setNumberOfPages() async {
    try {
      final paginatedCharacters = await Repository.fetchEntity(
        CharacterModel.endPoint,
        (json) => PaginatedCharacters.fromJson(json),
        page: 1,
        property: queryParameterTuple,
      );

      numberOfPages = paginatedCharacters.numberOfPages;
    } on ApiException {
      rethrow;
    }
  }

  Future<void> fetchCharacters() async {
    if (page >= numberOfPages) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final paginatedCharacters = await Repository.fetchEntity(
        CharacterModel.endPoint,
        (json) => PaginatedCharacters.fromJson(json),
        page: page,
        property: queryParameterTuple,
      );

      setState(() {
        characters.addAll(paginatedCharacters.results);
        page++;
        isLoading = false;
      });
    } on ApiException {
      rethrow;
    }
  }

  Future<void> _refresh() async {
    await WidgetsBinding.instance.endOfFrame;

    setState(() {
      characters = [];
      isLoading = false;
      isConnecting = true;
      _isShowingError = false;
      page = 1;
    });

    await fetch();
  }

  void collapseAppBar() {
    final expandedHeight = SliverAppBarWidget.expandedHeight;
    final toolbarHeight = SliverAppBarWidget.toolbarHeight;

    final collapseOffset = expandedHeight - toolbarHeight;

    _scrollController.animateTo(
      collapseOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    setState(() {
      _isTextFieldShowing = true;
    });
  }

  void onChanged(String text) {
    setState(() {
      this.text = text;
    });

    _debounce?.cancel();

    _debounce = Timer(Duration(milliseconds: 500), () {
      queryParameterTuple = (selectedFilter, text);
      _refresh();
    });
  }

  void onEditingComplete() {
    focusNode.unfocus();
    queryParameterTuple = (selectedFilter, text);
    _refresh();
  }

  void onFilterSelected(String filter) {
    setState(() {
      selectedFilter = filter;
    });

    onEditingComplete();
  }

  void openFilters() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.appBarColor,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: FiltersWidget(
            filters: CharacterPropertyType.values
                .map((element) => element.name)
                .toList(),
            initialSelectedFilter: selectedFilter,
            onFilterSelected: onFilterSelected,
          ),
        );
      },
    );
  }

  void refreshAndCollapse() {
    _refresh();
    collapseAppBar();
  }

  String? getEmptyText() {
    if (error?.statusCode == 404) {
      return 'No character found with that $selectedFilter.';
    }

    return error?.message;
  }

  void tryAgain() {
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: AppColors.cardFooterColor,
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBarWidget(
              leftIcon: _isAppBarCollapsed && _isTextFieldShowing
                  ? SizedBox.shrink()
                  : IconButton(
                      onPressed: () => Void,
                      icon: Icon(
                        Icons.menu,
                        color: AppColors.leftIconColor,
                        size: 24,
                      ),
                    ),
              actions: _isAppBarCollapsed
                  ? [
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: IconButton(
                          onPressed: _isTextFieldShowing
                              ? openFilters
                              : collapseAppBar,
                          icon: Icon(
                            _isTextFieldShowing
                                ? Icons.filter_list
                                : Icons.search,
                            color: _isTextFieldShowing
                                ? AppColors.cardFooterColor
                                : AppColors.rightIconColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ]
                  : [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          onPressed: _isShowingError
                              ? refreshAndCollapse
                              : collapseAppBar,
                          icon: Icon(
                            Icons.search,
                            color: _isTextFieldShowing
                                ? AppColors.cardFooterColor
                                : AppColors.rightIconColor,
                            size: 24,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: IconButton(
                          onPressed: () => Void,
                          icon: Icon(
                            CupertinoIcons.person_crop_circle,
                            color: AppColors.rightIconColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
              titleWidget: _isAppBarCollapsed && _isTextFieldShowing
                  ? TextFieldWidget(
                      onChanged: onChanged,
                      onEditingComplete: onEditingComplete,
                      controller: _textEditingController,
                      focusNode: focusNode,
                    )
                  : AppTitleWidget(),
            ),

            if (isConnecting)
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 15,
                    ),
                    child: ShimmerWidget.rectangular(
                      height: 160,
                      borderRadius: 10,
                    ),
                  );
                }),
              )
            else if (_isShowingError)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyWidget(text: getEmptyText(), onTapButton: _refresh),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == characters.length) {
                    if (isLoading) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.cardFooterColor,
                          ),
                        ),
                      );
                    }

                    return SizedBox(height: 40);
                  }

                  final character = characters[index];

                  return HomeCardWidget(
                    character: character,
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(DetailsPage.routeId, arguments: character);
                    },
                  );
                }, childCount: characters.length + 1),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
