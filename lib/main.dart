import 'package:agritech/models/Favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/home.dart';
import './pages/more_details.dart';
import './pages/favorites_page.dart';
import './pages/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Favorite(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.green,
          primarySwatch: Colors.green,
          accentColor: Colors.green.shade400,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: Home(),
        routes: {
          '/': (ctx) => TabsScreen(),
          MoreDetails.routeName: (ctx) => MoreDetails(),
          FavoritesPage.routeName: (ctx) => FavoritesPage()
        },
      ),
    );
  }
}
