import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final Map<String, dynamic> fieldInfo;
  final Map<String, dynamic> nextFieldInfo;
  final Function onSubmit;

  CustomTextField({
    Key key,
    this.fieldInfo,
    this.onSubmit,
    this.nextFieldInfo,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    final isPassword = widget.fieldInfo['obscure'];
    // final widget.nextFieldInfo = widget.index < (widget.controller.inputs.length - 1)
    //     ? widget.index + 1
    //     : null;

    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[A-Za-z0-9:;?/!.@#$%¨&*()_+=-\s]')),
      ],
      validator: (str) {
        if (str == null || str.isEmpty) return 'This field is required';
        return null;
      },
      controller: widget.fieldInfo['controller'],
      obscureText: isPassword ? !visible : false,
      focusNode: widget.fieldInfo['focusNode'],
      textInputAction: widget.nextFieldInfo != null
          ? TextInputAction.next
          : TextInputAction.done,
      decoration: InputDecoration(
        hintText: 'Type your ${widget.fieldInfo['label'].toLowerCase()}',
        border: OutlineInputBorder(),
        labelText: widget.fieldInfo['label'],
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
      onFieldSubmitted: (_) => widget.nextFieldInfo != null
          ? FocusScope.of(context)
              .requestFocus(widget.nextFieldInfo['focusNode'])
          : widget.onSubmit(),
    );
  }
}
