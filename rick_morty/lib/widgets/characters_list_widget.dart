import 'package:flutter/material.dart';
import 'package:rick_morty/pages/details_page.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/widgets/character_card_widget.dart';
import 'package:rick_morty/widgets/shimmer_widget.dart';

class CharactersListWidget extends StatelessWidget {
  final List<dynamic> entities;
  final bool isLoading;
  final bool isConnecting;
  final int minimumLength;

  const CharactersListWidget({
    super.key,
    required this.entities,
    required this.isLoading,
    required this.isConnecting,
    required this.minimumLength,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (isConnecting) {
          return Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
            child: ShimmerWidget.rectangular(
              height: 160, 
              borderRadius: 10,
              baseColor: AppColors.baseShimmerColor(context),
              highlightColor: AppColors.highlightShimmerColor(context),
            ),
          );
        } else {
          if (index == entities.length) {
            if (isLoading) {
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor(context),
                  ),
                ),
              );
            }

            return SizedBox(height: 40);
          }

          final character = entities[index];

          return Column(
            children: [
              CharacterCardWidget(
                character: character,
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(DetailsPage.routeId, arguments: character);
                },
              ),

              if (entities.length < minimumLength &&
                  index == entities.length - 1)
                SizedBox(
                  height: 150 * (minimumLength - entities.length).toDouble(),
                ),
            ],
          );
        }
      }, childCount: isConnecting ? 10 : entities.length + 1),
    );
  }
}
