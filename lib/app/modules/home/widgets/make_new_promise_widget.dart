import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../enums.dart';
import '../pages/contacts/presenter/contacts_controller.dart';
import '../models/user_model.dart';

class MakeNewPromiseDialog extends StatefulWidget {
  final preSelectedPromiseTarget;

  const MakeNewPromiseDialog({Key key, this.preSelectedPromiseTarget})
      : super(key: key);

  @override
  _MakeNewPromiseDialogState createState() => _MakeNewPromiseDialogState();
}

class _MakeNewPromiseDialogState extends State<MakeNewPromiseDialog> {
  final List<User> _contacts = Modular.get<ContactsController>().contacts;
  PromiseType selectedPromiseType;
  User selectedPromiseTarget;
  int quantity = 0;

  @override
  void initState() {
    selectedPromiseTarget = widget.preSelectedPromiseTarget;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Make a new promise',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 15),
              Text('Promise target', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 5),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  isExpanded: true,
                  hint: Text('Select a target'),
                  value: selectedPromiseTarget,
                  isDense: true,
                  items: _contacts
                      .map((c) => DropdownMenuItem(
                            child: Tooltip(
                              message: c.uid,
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text(
                                    '${c.name} (${c.email})',
                                  ))
                                ],
                              ),
                            ),
                            value: c,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPromiseTarget = value;
                    });
                  }),
              SizedBox(height: 15),
              Text('Promise type', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 5),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  isExpanded: true,
                  isDense: true,
                  hint: Text('Select a promise type'),
                  value: selectedPromiseType,
                  items: PromiseType.values
                      .map((t) => DropdownMenuItem(
                            child: Text('${t.name}'),
                            value: t,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPromiseType = value;
                    });
                  }),
              SizedBox(height: 15),
              Text('Quantity', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.grey[600])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (quantity > 0)
                          ? () {
                              setState(() {
                                quantity -= 1;
                              });
                            }
                          : null,
                      icon: Icon(Icons.remove),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: '$quantity', style: TextStyle(fontSize: 20)),
                      TextSpan(
                          text: ' ${quantity == 1 ? 'promise' : 'promises'}',
                          style: TextStyle(fontSize: 16))
                    ])),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            quantity += 1;
                          });
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'CANCEL',
                            style: TextStyle(color: Colors.red),
                          ))),
                  Expanded(
                      child: FlatButton(
                          onPressed: (quantity > 0 &&
                                  selectedPromiseTarget != null &&
                                  selectedPromiseType != null)
                              ? () {
                                  Navigator.pop(context, {
                                    'selectedPromiseTarget':
                                        selectedPromiseTarget,
                                    'selectedPromiseType': selectedPromiseType,
                                    'quantity': quantity
                                  });
                                }
                              : null,
                          child: Text('MAKE')))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
