import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final int index;
  final controller;

  CustomTextField({Key key, this.index, this.controller}) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    final isPassword = widget.controller.inputs[widget.index]['obscure'];
    final nextInput = widget.index < (widget.controller.inputs.length - 1)
        ? widget.index + 1
        : null;

    return TextFormField(
      validator: (str) {
        if (str == null || str.isEmpty) return 'This field is required';
        return null;
      },
      controller: widget.controller.inputs[widget.index]['controller'],
      obscureText: isPassword ? !visible : false,
      focusNode: widget.controller.inputs[widget.index]['focusNode'],
      decoration: InputDecoration(
        hintText:
            'Type your ${widget.controller.inputs[widget.index]['label'].toLowerCase()}',
        border: OutlineInputBorder(),
        labelText: widget.controller.inputs[widget.index]['label'],
        suffixIcon: isPassword
            ? FlatButton(
                child: Text(visible ? 'UNSHOW' : 'SHOW'),
                onPressed: () {
                  setState(() {
                    visible = !visible;
                  });
                },
              )
            : null,
      ),
      onFieldSubmitted: (_) => nextInput != null
          ? FocusScope.of(context)
              .requestFocus(widget.controller.inputs[nextInput]['focusNode'])
          : widget.controller.mainFunction(),
    );
  }
}
