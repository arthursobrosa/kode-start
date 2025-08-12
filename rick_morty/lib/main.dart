import 'package:flutter/material.dart';
import 'package:rick_morty/models/character_model.dart';
import 'package:rick_morty/pages/details_page.dart';
import 'package:rick_morty/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case HomePage.routeId:
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (context) => HomePage(),
            );
          case DetailsPage.routeId:
            CharacterModel character = routeSettings.arguments as CharacterModel;

            return MaterialPageRoute(
              settings: routeSettings,
              builder: (context) =>
                  DetailsPage(character: character),
            );
          default:
            return null;
        }
      },
      home: const HomePage()
    );
  }
}
