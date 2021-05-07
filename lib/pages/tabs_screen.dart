import 'package:flutter/material.dart';

import 'home.dart';
import 'favorites_page.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {"page": Home(), "title": "home"},
      {"page": FavoritesPage(), "title": "Favorites"}
    ];
    super.initState();
  }

  int selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
        title: Text(_pages[selectedIndex]["title"]),
      ), */
      /*  drawer: Drawer(
        child: MainDrawer(),
      ), */
      body: _pages[selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black87,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: "Categories"),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              label: "Favorites")
        ],
      ),
    );
  }
}
