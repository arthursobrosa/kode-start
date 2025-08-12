import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/text_type.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key, 
    required this.isDetailsPage,
    required this.onTapLeftIcon
  });

  final bool isDetailsPage;
  final void Function() onTapLeftIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appBarColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 14, 
            left: 14, 
            top: 18
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTapLeftIcon,
                  child: Icon(
                    isDetailsPage ? Icons.arrow_back : Icons.menu,
                    color: AppColors.leftIconColor,
                    size: 24,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png', scale: 3),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'RICK AND MORTY API',
                        style: TextType.appTitle.textSyle,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                CupertinoIcons.person_crop_circle,
                color: AppColors.rightIconColor,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(131);
}
