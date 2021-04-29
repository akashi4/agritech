import 'package:agritech/pages/more_details.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appbar'),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: 9,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(MoreDetails.routeName);
                    },
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      //color: Theme.of(context).primaryColor,
                      child: Container(
                        height: 200,
                        //color: Colors.blue,
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
