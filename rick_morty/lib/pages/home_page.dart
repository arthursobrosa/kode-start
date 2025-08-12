import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/data/repository.dart';
import 'package:rick_morty/pages/details_page.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/widgets/sliver_app_bar_widget.dart';
import 'package:rick_morty/widgets/home_card_widget.dart';
import 'package:rick_morty/widgets/shimmer_widget.dart';

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
  late final int numberOfPages;
  int page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _init();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchCharacters();
      }
    });

    super.initState();
  }

  Future<void> _init() async {
    await setNumberOfPages();
    await fetchCharacters();
    setState(() {
      isConnecting = false;
    });
  }

  Future<void> setNumberOfPages() async {
    final paginatedCharacters = await Repository.getPaginatedCharacters(
      page: 1,
    );

    numberOfPages = paginatedCharacters.numberOfPages;
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

    final paginatedCharacters = await Repository.getPaginatedCharacters(
      page: page,
    );

    setState(() {
      characters.addAll(paginatedCharacters.results);
      page++;
      isLoading = false;
    });
  }

  Future<void> _refresh() async {
    await WidgetsBinding.instance.endOfFrame;

    setState(() {
      characters = [];
      isLoading = false;
      isConnecting = true;
      page = 1;
    });

    await fetchCharacters();

    setState(() {
      isConnecting = false;
    });
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
              isDetailsPage: false,
              onTapLeftIcon: () => Void,
              onTapRightIcon: () => Void,
            ),

            isConnecting
                ? SliverList(
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
                : SliverList(
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
                          Navigator.of(context).pushNamed(
                            DetailsPage.routeId,
                            arguments: character,
                          );
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
    super.dispose();
  }
}
