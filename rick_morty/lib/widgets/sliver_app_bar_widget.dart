import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/app_image_paths.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    super.key,
    required this.leftIcon,
    required this.actions,
    required this.titleWidget,
  });

  final Widget leftIcon;
  final List<Widget>? actions;
  final Widget titleWidget;

  static double get expandedHeight => 131;
  static double get toolbarHeight => 50;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.secondaryColor,
      pinned: true,
      stretch: true,
      expandedHeight: expandedHeight,
      toolbarHeight: toolbarHeight,
      leading: leftIcon,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image.asset(
            AppImagePaths.logo, 
            scale: 3
          ),
        ),
        title: titleWidget,
        stretchModes: const [StretchMode.fadeTitle, StretchMode.blurBackground],
        expandedTitleScale: 1,
      ),
    );
  }
}
