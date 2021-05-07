import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/Favorites.dart';

class MoreDetails extends StatefulWidget {
  static const routeName = '/MoreDetail';

  @override
  _MoreDetailsState createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  /*  dynamic feed;

  int index;
 */
  bool addtoList = false;

  void changeFavorite() {
    setState(() {
      addtoList = !addtoList;
    });
  }

  showError() {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Une erreur est survenue'),
            content: Text(
                "Un probleme est survenu lors de l'ouverture du navigateur"),
            actions: [
              TextButton(
                child: Text('Okay'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Future<dynamic> openLink(String link) async {
    try {
      await launch(link, forceWebView: false, forceSafariVC: true);
    } catch (e) {
      showError;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<Favorite>(context);
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final feed = args['feed'];
    int index = args['index'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Plus de details'),
        actions: [
          PopupMenuButton(
              enabled: true,
              onSelected: (int selectedvalue) {
                if (selectedvalue == 1) {
                  openLink(feed.items[index].link);
                } else {
                  Share.share(feed.items[index].link);
                }
              },
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.share, color: Colors.green),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'SHARE',
                          )
                        ],
                      ),
                      value: 0,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.arrow_forward, color: Colors.green),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Open in Navigator')
                        ],
                      ),
                      value: 1,
                    )
                  ])
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Text(
                feed.items[index].title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            height: 250,
            width: double.infinity,
            color: Colors.green,
          ),
          Html(data: feed.items[index].description),
          TextButton(
              onPressed: () {
                openLink(feed.items[index].link);
              },
              child: Text('Aller voir sur le site'))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          changeFavorite();
          if (addtoList) {
            favorite.addToFavorite(feed.items[index]);
          } else {
            favorite.removeInFavorite(feed.items[index]);
          }
        },
        child: addtoList ? Icon(Icons.star) : Icon(Icons.star_border),
      ),
    );
  }
}
