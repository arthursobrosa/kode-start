import 'package:flutter/material.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/card_text_type.dart';
import 'package:rick_morty/utils/string_extension.dart';

class DetailedCardWidget extends StatelessWidget {
  const DetailedCardWidget({super.key, required this.character});

  final CharacterModel character;

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
            Image.network(
              character.imagePath,
              fit: BoxFit.cover,
              height: 160,
            ),
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
                      child: Text(
                        '${character.status.capitalize()} - ${character.species}',
                        style: CardTextType.description.textSyle,
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
                        'Earth (Replacement Dimension)',
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
                        'Total Rickall',
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
