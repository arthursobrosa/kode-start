import 'package:flutter/material.dart';
import 'package:rick_morty/data/repository.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/widgets/app_bar_widget.dart';
import 'package:rick_morty/widgets/detailed_card_widget.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/details';
  const DetailsPage({super.key, required this.characterId});

  final int characterId;

  @override
  State<DetailsPage> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  Future<CharacterModel>? character;

  @override
  void initState() {
    character = Repository.getCharacter(widget.characterId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarWidget(
        isDetailsPage: true,
        onTapLeftIcon: () {
          Navigator.pop(context);
        },
      ),
      body: FutureBuilder(
        future: character,
        builder: (context, AsyncSnapshot<CharacterModel> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;

            return DetailedCardWidget(character: data);
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
