import 'package:flutter/material.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/models/episode_model.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/card_text_type.dart';
import 'package:rick_morty/utils/string_extension.dart';
import 'package:rick_morty/widgets/status_circle_widget.dart';

class DetailedCardWidget extends StatelessWidget {
  const DetailedCardWidget({
    super.key, 
    required this.character,
    required this.episode
  });

  final CharacterModel character;
  final EpisodeModel? episode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(character.imagePath, fit: BoxFit.cover, height: 160),
            Container(
              color: AppColors.cardFooterColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 43),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        character.name.toUpperCase(),
                        style: CardTextType.title.textSyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 38),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StatusCircleWidget(
                            status: character.status,
                            circleSize: Size(8, 8),
                            strokeWidth: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              '${character.status.capitalize()} - ${character.species}',
                              style: CardTextType.description.textSyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Last known location:',
                        style: CardTextType.subDescription.textSyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        character.lastKnownLocation,
                        style: CardTextType.description.textSyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'First seen in:',
                        style: CardTextType.subDescription.textSyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        episode != null ? episode!.name : 'Unknwon',
                        style: CardTextType.description.textSyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
