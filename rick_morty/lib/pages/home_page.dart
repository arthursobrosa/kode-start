import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/data/repository.dart';
import 'package:rick_morty/pages/details_page.dart';
import 'package:rick_morty/pages/home_view_model.dart';
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
  final HomeViewModel _viewModel = HomeViewModel();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late String _selectedFilter;
  String _textFieldText = '';
  bool _isTextFieldShowing = false;
  bool _isAppBarCollapsed = false;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _setInitialSelectedFilter();
    _fetch();

    _scrollController.addListener(_scrollListener);
    _scrollController.addListener(_appBarListener);
  }

  void _setInitialSelectedFilter() {
    final filters = CharacterPropertyType.values
        .map((element) => element.name)
        .toList();

    _selectedFilter = filters.first;
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetch();
    }
  }

  void _appBarListener() {
    double expandedHeight = SliverAppBarWidget.expandedHeight;
    double toolbarHeight = SliverAppBarWidget.toolbarHeight;

    bool isExpanded =
        _scrollController.hasClients &&
        _scrollController.offset < (expandedHeight - toolbarHeight);

    if (isExpanded == _isAppBarCollapsed) {
      setState(() {
        _isAppBarCollapsed = !isExpanded;

        if (!_isAppBarCollapsed &&
            _isTextFieldShowing &&
            _textFieldText.isEmpty) {
          _isTextFieldShowing = false;
        }
      });
    }
  }

  Future<void> _fetch() async {
    try {
      await _viewModel.fetch();
    } on ApiException catch (error) {
      if (kDebugMode) {
        print(error);
      }

      _viewModel.setError(error);

      setState(() {
        _textFieldText = '';
        _textEditingController.text = _textFieldText;
        _isTextFieldShowing = false;
      });

      _focusNode.unfocus();
    }

    _viewModel.changeConnection(isConnecting: false);
  }

  Future<void> _refresh() async {
    await WidgetsBinding.instance.endOfFrame;

    _viewModel.resetHomeData();

    await _fetch();
  }

  void _collapseAppBar() {
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

  void _openFilters() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.appBarColor,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: FiltersWidget(
            filters: CharacterPropertyType.values
                .map((element) => element.name)
                .toList(),
            initialSelectedFilter: _selectedFilter,
            onFilterSelected: _onFilterSelected,
          ),
        );
      },
    );
  }

  void _onChanged(String text) {
    setState(() {
      _textFieldText = text;
    });

    _debounce?.cancel();

    _debounce = Timer(Duration(milliseconds: 500), () {
      _viewModel.updateQuery(
        selectedFilter: _selectedFilter,
        textFieldText: _textFieldText,
      );

      _refresh();
    });
  }

  void _onEditingComplete() {
    _focusNode.unfocus();

    _viewModel.updateQuery(
      selectedFilter: _selectedFilter,
      textFieldText: _textFieldText,
    );

    _refresh();
  }

  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
    });

    _onEditingComplete();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeData>(
      valueListenable: _viewModel.homeData,
      builder: (_, data, _) {
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
                                  ? _openFilters
                                  : _collapseAppBar,
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
                              onPressed: () {
                                if (data.isShowingError) {
                                  _refresh();
                                }

                                _collapseAppBar();
                              },
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
                          onChanged: _onChanged,
                          onEditingComplete: _onEditingComplete,
                          controller: _textEditingController,
                          focusNode: _focusNode,
                        )
                      : AppTitleWidget(),
                ),

                if (data.isConnecting)
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
                else if (data.isShowingError)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyWidget(
                      text: _viewModel.getEmptyText(
                        selectedFilter: _selectedFilter,
                      ),
                      onTapButton: _refresh,
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index == data.characters.length) {
                        if (data.isLoading) {
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

                      final character = data.characters[index];

                      return HomeCardWidget(
                        character: character,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            DetailsPage.routeId,
                            arguments: character,
                          );
                        },
                      );
                    }, childCount: data.characters.length + 1),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
