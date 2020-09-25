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
                CircleAvatar(
                  minRadius: 30,
                  maxRadius: 50,
                  backgroundImage:
                      NetworkImage("https://picsum.photos/id/237/536/354"),
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
