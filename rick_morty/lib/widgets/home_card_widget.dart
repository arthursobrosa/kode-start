import 'package:flutter/material.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/text_type.dart';
import 'package:rick_morty/widgets/shimmer_widget.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({
    super.key,
    required this.character,
    required this.onTap,
  });

  final CharacterModel character;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Stack(
            children: [
              Image.network(
                character.imagePath,
                fit: BoxFit.cover,
                height: 160,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return ShimmerWidget.rectangular(
                    height: 160,
                    borderRadius: 10,
                  );
                },
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: AppColors.cardFooterColor,
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 16,
                    right: 16,
                    bottom: 11,
                  ),
                  child: Text(
                    character.name.toUpperCase(),
                    style: TextType.title.textSyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
