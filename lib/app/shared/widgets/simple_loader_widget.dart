import 'package:flutter/material.dart';

class SimpleLoader extends StatelessWidget {
  final bool withScaffold;

  const SimpleLoader({Key key, this.withScaffold: false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _buildLoader = Center(
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).indicatorColor),
      ),
    );

    if (!withScaffold) {
      return _buildLoader;
    }
    return Scaffold(
      body: _buildLoader,
    );
  }
}
