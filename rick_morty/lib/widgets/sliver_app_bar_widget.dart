import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/text_type.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    super.key,
    required this.isDetailsPage,
    required this.onTapLeftIcon,
    required this.onTapRightIcon
  });

  final bool isDetailsPage;
  final void Function() onTapLeftIcon;
  final void Function() onTapRightIcon;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.appBarColor,
      pinned: true,
      stretch: true,
      expandedHeight: 131,
      toolbarHeight: 50,
      leading: IconButton(
        onPressed: onTapLeftIcon,
        icon: Icon(
          isDetailsPage ? Icons.arrow_back : Icons.menu, 
          color: AppColors.leftIconColor,
           size: 24
        )
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            onPressed: onTapRightIcon, 
            icon: Icon(
              CupertinoIcons.person_crop_circle,
              color: AppColors.rightIconColor,
              size: 24,
            )
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image.asset('assets/images/logo.png', scale: 3),
        ),
        title: Text('RICK AND MORTY API', style: TextType.appTitle.textSyle),
        stretchModes: const [StretchMode.fadeTitle, StretchMode.blurBackground],
        expandedTitleScale: 1,
      ),
    );
  }
}