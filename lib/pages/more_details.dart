import 'package:flutter/material.dart';

class MoreDetails extends StatelessWidget {
  static const routeName = '/MoreDetail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real AppBar'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
//            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Theme.of(context).appBarTheme.color,
              ),
              title: Text('Content Title'),
            ),
            expandedHeight: 200,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.star_border),
      ),
    );
  }
}
