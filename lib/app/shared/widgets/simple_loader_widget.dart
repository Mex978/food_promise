import 'package:flutter/material.dart';

class SimpleLoader extends StatelessWidget {
  final bool withScaffold;
  final Color indicatorColor;

  const SimpleLoader({Key key, this.withScaffold = false, this.indicatorColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _buildLoader = Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            indicatorColor ?? Theme.of(context).indicatorColor),
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
