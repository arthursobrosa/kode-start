import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/data/repository.dart';
import 'package:rick_morty/pages/details_page.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/widgets/app_bar_widget.dart';
import 'package:rick_morty/widgets/home_card_widget.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CharacterModel> characters = [];
  bool isLoading = false;
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
  }

  Future<void> setNumberOfPages() async {
    final paginatedCharacters = await Repository.getPaginatedCharacters(
      page: 1,
    );

    numberOfPages = paginatedCharacters.numberOfPages;
  }

  Future<void> fetchCharacters() async {
    if (page >= numberOfPages) {
      isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarWidget(isDetailsPage: false, onTapLeftIcon: () => Void),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: characters.length + 1,
        itemBuilder: (context, index) {
          if (index == characters.length) {
            if (isLoading) {
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return SizedBox.shrink();
          }

          final character = characters[index];

          return HomeCardWidget(
            character: character,
            onTap: () {
              Navigator.of(context).pushNamed(
                DetailsPage.routeId,
                arguments: {
                  'characterId': character.id,
                  'episodeId': character.firstEpisodeId,
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
