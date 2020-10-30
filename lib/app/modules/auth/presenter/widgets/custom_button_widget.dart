import 'package:flutter/material.dart';
import 'package:food_promise/app/shared/utils.dart';
import 'package:food_promise/app/shared/widgets/simple_loader_widget.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final bool isLoading;
  final String text;
  final bool darkColor;

  const CustomButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.darkColor = false,
    this.isLoading = false,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) return SimpleLoader();
    return Container(
      height: 48,
      child: RaisedButton(
          color: darkColor
              ? Theme.of(context).primaryColor
              : Theme.of(context).accentColor,
          onPressed: () {
            Future.delayed(
              Duration(milliseconds: 200),
              () {
                FoodPromiseUtils.hideKeyboard(context);
                onPressed();
              },
            );
          },
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}
