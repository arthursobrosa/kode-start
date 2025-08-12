import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            int characterId = routeSettings.arguments as int;
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (context) => DetailsPage(characterId: characterId),
            );
          default:
            return null;
        }
      },
      home: const HomePage(),
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
