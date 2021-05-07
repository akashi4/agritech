import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';
import 'package:intl/intl.dart';

import '../models/Favorites.dart';
import './more_details.dart';

class FavoritesPage extends StatelessWidget {
  static const routeName = '/Favorites';

  @override
  Widget build(BuildContext context) {
    final favoritesClass = Provider.of<Favorite>(context);
    //List<RssItem> favorites = favoritesClass.favorites;
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorite'),
        ),
        body: favoritesClass.itemCounts == 0
            ? Center(
                child: Text(
                'Nothing has been added yet!',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ))
            : ListView.builder(
                itemCount: favoritesClass.favorites.length,
                itemBuilder: (ctx, i) {
                  final item = favoritesClass.favorites[i];
                  return InkWell(
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMEd().format(item.pubDate),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w100,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        //leading: thumbnail(item.enclosure.url),
                        trailing: Icon(Icons.arrow_right),
                        contentPadding: EdgeInsets.all(7.0),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(ctx, MoreDetails.routeName,
                          arguments: {'feed': favoritesClass, 'index': i});
                    },
                  );
                }));
  }
}
