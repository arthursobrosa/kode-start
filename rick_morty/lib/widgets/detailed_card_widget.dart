import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';

class DetailedCardWidget extends StatelessWidget {
  const DetailedCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 17,
        left: 20,
        right: 20
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/morty.png',
              fit: BoxFit.cover,
              height: 160,
            ),
            Container(
              color: AppColors.cardFooterColor,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 43
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12
                      ),
                      child: Text(
                        'baby wizard'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textColor
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 38
                      ),
                      child: Text(
                        'Dead - Alien',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15
                      ),
                      child: Text(
                        'Last know location:',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w300,
                          color: AppColors.textColor
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4
                      ),
                      child: Text(
                        'Earth (Replacement Dimension)',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15
                      ),
                      child: Text(
                        'First seen in:',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w300,
                          color: AppColors.textColor
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4
                      ),
                      child: Text(
                        'Total Rickall',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}