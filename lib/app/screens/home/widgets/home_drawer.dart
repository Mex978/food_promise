import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final options = List.generate(5, (index) => "Option ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    imageUrl: 'https://picsum.photos/id/237/536/354',
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Container(
                      color: Theme.of(context).canvasColor,
                      width: 100,
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                    ),
                    errorWidget: (context, url, error) => Text('Error'),
                  ),
                ),
                Spacer(),
                Text('Fulano de tal'),
                Spacer(),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ]..addAll(options.map((option) => ListTile(
              onTap: () {},
              title: Text(option),
            ))),
      ),
    );
  }
}
