import 'package:flutter/material.dart';

class SignUpWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: 0),
        onPressed: () {},
        child: Stack(
          children: [
            Center(
              child: Text(
                'SIGN UP WITH GOOGLE',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                    'https://imagens.canaltech.com.br/empresas/690.400.jpg',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
