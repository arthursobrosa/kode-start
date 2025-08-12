import 'package:flutter/material.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/models/episode_model.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/text_type.dart';
import 'package:rick_morty/utils/string_extension.dart';
import 'package:rick_morty/widgets/status_circle_widget.dart';

class DetailedCharacterCardWidget extends StatelessWidget {
  const DetailedCharacterCardWidget({
    super.key,
    required this.character,
    required this.episode,
  });

  final CharacterModel character;
  final EpisodeModel? episode;

  List<Widget> detailedInfoWidgets() {
    List<Widget> children = [];
    Map<String, String> map = {};

    map['Gender:'] = character.gender;
    map['Origin:'] = character.origin.capitalize();
    map['Last known location:'] = character.lastKnownLocation.capitalize();
    map['First seen in:'] = episode != null ? episode!.name : 'Unknown';

    map.forEach((key, value) {
      Widget keyWidget = Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text(key, style: TextType.bodySmall.textSyle),
      );

      Widget valueWidget = Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(value, style: TextType.bodyRegular.textSyle),
      );

      children.add(keyWidget);
      children.add(valueWidget);
    });

    return children;
  }

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
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              height: 160,
            ),
            Container(
              color: AppColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 43),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        character.name.toUpperCase(),
                        style: TextType.boldTitle.textSyle,
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
                              style: TextType.bodyRegular.textSyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...detailedInfoWidgets(),
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
