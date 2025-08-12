import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rick_morty/pages/details_page.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/widgets/app_bar_widget.dart';
import 'package:rick_morty/widgets/home_card_widget.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarWidget(
        isDetailsPage: false,
        onTapLeftIcon: () => Void,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return HomeCardWidget(
            onTap: () {
              Navigator.of(context).pushNamed(
                DetailsPage.routeId
              );
            },
          );
        },
        itemCount: 3,
      ),
    );
  }
}