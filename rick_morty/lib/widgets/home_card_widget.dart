import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(
        left: 20, 
        right: 20, 
        top: 15
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/morty.png', 
              fit: BoxFit.cover
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.cardFooterColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 16,
              right: 16,
              child: Text(
                'baby wizard'.toUpperCase(),
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
