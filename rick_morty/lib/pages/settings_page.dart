import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/app_image_paths.dart';
import 'package:rick_morty/theme/app_theme.dart';
import 'package:rick_morty/theme/text_type.dart';
import 'package:rick_morty/widgets/app_title_widget.dart';
import 'package:rick_morty/widgets/sliver_app_bar_widget.dart';

class SettingsPage extends StatefulWidget {
  static const routeId = '/settings';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isToggled = true;

  void _setTheme() {
    AppTheme.setTheme(_isToggled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            backgroundColor: AppColors.secondaryColor(context),
            leftIcon: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.leftIconColor(context),
                size: 24,
              ),
            ),
            actions: [],
            titleWidget: AppTitleWidget(
              textStyle: TextType.spacedTitle.textSyle(context),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Enable dark mode',
                        style: TextType.spacedTitle.textSyle(context),
                      ),

                      Switch(
                        value: _isToggled,
                        onChanged: (value) {
                          setState(() {
                            _isToggled = value;
                          });

                          _setTheme();
                        },
                        activeColor: AppColors.primaryColor(context),
                        activeTrackColor: AppColors.primaryColor(
                          context,
                        ).withAlpha(128),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Image.asset(
                      AppImagePaths.pickleRick,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
