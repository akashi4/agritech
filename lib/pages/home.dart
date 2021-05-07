import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/more_details.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  final String title = 'TITLE PREDEFINED IN THE CODE';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const feed_url = 'https://www.lavoixdupaysan.net/feed/';
  String _title;
  RssFeed _feed;
  static const loadingFeedMessage = 'Loading feed...';
  static const imageHolderLocation = 'assets/images/no_image.png';
  GlobalKey<RefreshIndicatorState> _refreshKey;

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      var response =
          await http.get(Uri.https('www.lavoixdupaysan.net', 'feed'));
      return RssFeed.parse(response.body);
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
  }

  void updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  void updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  load() async {
    updateTitle(loadingFeedMessage);
    loadFeed().then((result) {
      if (result == null || result.toString().isEmpty) {
        updateTitle('Loading feed failed');
        return;
      }
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  Widget title(title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget subtitle(subtitle) {
    return Text(
      subtitle,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w100,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  thumbnail(imageUrl) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: CachedNetworkImage(
          placeholder: (ctx, url) => Image.asset(
            imageHolderLocation,
          ),
          imageUrl: imageUrl,
          height: 50,
          width: 70,
          alignment: Alignment.center,
          fit: BoxFit.fill,
        ));
  }

  list() {
    return ListView.builder(
        itemCount: _feed.items.length,
        itemBuilder: (ctx, i) {
          final item = _feed.items[i];
          return InkWell(
            child: Card(
              elevation: 5,
              child: ListTile(
                title: title(item.title),
                subtitle: subtitle(DateFormat.yMMMEd().format(item.pubDate)),
                //leading: thumbnail(item.enclosure.url),
                trailing: Icon(Icons.arrow_right),
                contentPadding: EdgeInsets.all(7.0),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(ctx, MoreDetails.routeName,
                  arguments: {'feed': _feed, 'index': i});
            },
          );
        });
  }

  isFeedEmpty() {
    return _feed == null || _feed.items == null;
  }

  Widget body() {
    return isFeedEmpty()
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            child: list(),
            onRefresh: () => load(),
            key: _refreshKey,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          /* actions: [
            IconButton(icon: Icon(Icons.refresh),onPressed: (){})
          ], */
        ),
        body: body());
  }
}
