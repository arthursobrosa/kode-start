import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/widgets/app_bar_widget.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/details';
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarWidget(
        isDetailsPage: true,
        onTapLeftIcon: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
