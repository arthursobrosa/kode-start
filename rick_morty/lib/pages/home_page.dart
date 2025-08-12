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
  Future<PaginatedCharacters>? characters;

  @override
  void initState() {
    characters = Repository.getPaginatedCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarWidget(isDetailsPage: false, onTapLeftIcon: () => Void),
      body: FutureBuilder(
        future: characters,
        builder: (context, AsyncSnapshot<PaginatedCharacters> snapshot) {
          if (snapshot.hasData) {
            final dataResults = snapshot.data!.results;

            return ListView.builder(
              itemBuilder: (context, index) {
                return HomeCardWidget(
                  character: dataResults[index],
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      DetailsPage.routeId,
                      arguments: {
                        'characterId': dataResults[index].id,
                        'episodeId': dataResults[index].firstEpisodeId
                      }
                    );
                  },
                );
              },
              itemCount: dataResults.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
