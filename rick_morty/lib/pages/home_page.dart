import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/data/repository.dart';
import 'package:rick_morty/view_models/home_view_model.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/text_type.dart';
import 'package:rick_morty/widgets/characters_list_widget.dart';
import 'package:rick_morty/widgets/drawer_widget.dart';
import 'package:rick_morty/widgets/empty_widget.dart';
import 'package:rick_morty/widgets/filters_widget.dart';
import 'package:rick_morty/widgets/simple_card_widget.dart';
import 'package:rick_morty/widgets/sliver_app_bar_widget.dart';
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

  String _textFieldText = '';
  bool _isTextFieldShowing = false;
  bool _isAppBarCollapsed = false;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _fetch();

    _scrollController.addListener(_scrollListener);
    _scrollController.addListener(_appBarListener);
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

  void _openFilters({
    required List<String> filters,
    required String selectedFilter,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.secondaryColor(context),
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: FiltersWidget(
            filters: filters,
            initialSelectedFilter: selectedFilter,
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
      _viewModel.updateQuery(textFieldText: _textFieldText);
      _refresh();
    });
  }

  void _onEditingComplete() {
    _focusNode.unfocus();
    _viewModel.updateQuery(textFieldText: _textFieldText);
    _refresh();
  }

  void _onFilterSelected(String filter) {
    _viewModel.updateSelectedFilter(filter);
    _onEditingComplete();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(_scrollListener);
    _scrollController.removeListener(_appBarListener);
    _scrollController.dispose();

    _textEditingController.dispose();

    _focusNode.dispose();

    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeData>(
      valueListenable: _viewModel.homeData,
      builder: (_, data, _) {
        return Scaffold(
          drawer: DrawerWidget(
            backgroundColor: AppColors.secondaryColor(context),
            items: List.generate(_viewModel.drawerOptions.length, (index) {
              final isSelected = index == data.selectedDrawerIndex;
              final drawerOption = _viewModel.drawerOptions[index];

              return ListTile(
                title: Text(
                  drawerOption,
                  style: isSelected
                      ? TextType.highlighted.textSyle(context)
                      : TextType.spacedTitle.textSyle(context),
                ),
                onTap: () {
                  _viewModel.updateSelectedDrawer(index);
                  setState(() {
                    _textFieldText = '';
                    _textEditingController.text = _textFieldText;
                    _isTextFieldShowing = false;
                  });
                  _viewModel.updateQuery(textFieldText: _textFieldText);
                  _refresh();
                },
              );
            }),
          ),
          endDrawer: DrawerWidget(
            backgroundColor: AppColors.secondaryColor(context),
            items: [
              ListTile(
                title: Text(
                  'Item 1', 
                  style: TextType.spacedTitle.textSyle(context)
                ),
                onTap: () => Void,
              ),
            ],
          ),
          backgroundColor: AppColors.backgroundColor(context),
          body: RefreshIndicator(
            color: AppColors.labelColor(context),
            backgroundColor: AppColors.primaryColor(context),
            onRefresh: _refresh,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBarWidget(
                  backgroundColor: AppColors.secondaryColor(context),
                  leftIcon: _isAppBarCollapsed && _isTextFieldShowing
                      ? SizedBox.shrink()
                      : Builder(
                          builder: (context) => IconButton(
                            onPressed: Scaffold.of(context).openDrawer,
                            icon: Icon(
                              Icons.menu,
                              color: AppColors.leftIconColor(context),
                              size: 24,
                            ),
                          ),
                        ),
                  actions: _isAppBarCollapsed
                      ? [
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: IconButton(
                              onPressed: _isTextFieldShowing
                                  ? () => _openFilters(
                                      filters: data.filters,
                                      selectedFilter: data.selectedFilter,
                                    )
                                  : _collapseAppBar,
                              icon: Icon(
                                _isTextFieldShowing
                                    ? Icons.filter_list
                                    : Icons.search,
                                color: _isTextFieldShowing
                                    ? AppColors.primaryColor(context)
                                    : AppColors.rightIconColor(context),
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
                                    ? AppColors.primaryColor(context)
                                    : AppColors.rightIconColor(context),
                                size: 24,
                              ),
                            ),
                          ),

                          Builder(
                            builder: (context) => Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: IconButton(
                                onPressed: Scaffold.of(context).openEndDrawer,
                                icon: Icon(
                                  CupertinoIcons.person_crop_circle,
                                  color: AppColors.rightIconColor(context),
                                  size: 24,
                                ),
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
                          backgroundColor: AppColors.backgroundColor(context),
                          cursorColor: AppColors.primaryColor(context),
                          inputStyle: TextType.inputText.textSyle(context),
                          placeholderStyle: TextType.inputPlaceholder.textSyle(context),
                        )
                      : AppTitleWidget(
                          textStyle: TextType.spacedTitle.textSyle(context)
                        ),
                ),

                if (data.isShowingError)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyWidget(
                      text: _viewModel.getEmptyText(),
                      onTapButton: _refresh,
                      textStyle: TextType.spacedTitle.textSyle(context),
                      buttonTextStyle: TextType.buttonText.textSyle(context),
                      buttonColor: AppColors.primaryColor(context),
                    ),
                  )
                else if (data.drawerOptionType == DrawerOptionType.characters)
                  CharactersListWidget(
                    entities: data.entities,
                    isLoading: data.isLoading,
                    isConnecting: data.isConnecting,
                    minimumLength: 5,
                  )
                else
                  SimpleCardWidget(
                    items: data.entities,
                    isLoading: data.isLoading,
                    isConnecting: data.isConnecting,
                    minimumLength: 8,
                    boxColor: AppColors.primaryColor(context),
                    textStyle: TextType.boldTitle.textSyle(context),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
