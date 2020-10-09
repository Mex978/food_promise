import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: RaisedButton(
        onPressed: () => Modular.link.pushNamed('/register'),
        child: Text(
          'SIGN UP',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
