import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  static const routeName = '/Favorites';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Favorite'),
    ));
  }
}
