import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/shared/utils.dart';

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
  DateTime promiseDate = DateTime.now();

  @override
  void initState() {
    selectedPromiseTarget = widget.preSelectedPromiseTarget;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_contacts == null || _contacts.isEmpty) {
      return AlertDialog(
        title: Text(
          'Error',
          style: TextStyle(color: Colors.white),
        ),
        content: Text('You don\'t have contacts yet'),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK')),
          FlatButton(
              color: Colors.white,
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pop(context);
                Modular.to.pushNamed('/home/contacts');
              },
              child: Text('ADD CONTACTS')),
        ],
      );
    }

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
              Text('Promise date', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.all(12),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        color: Colors.white38,
                      )),
                  child: Row(
                    children: [
                      Text(FoodPromiseUtils.timestampToHuman(
                          promiseDate.millisecondsSinceEpoch)),
                      Spacer(),
                      Icon(Icons.date_range),
                    ],
                  ),
                  onPressed: () async {
                    final _date = await showDatePicker(
                        context: context,
                        initialDate: promiseDate,
                        firstDate: DateTime(2016),
                        lastDate: DateTime.now());
                    setState(() {
                      promiseDate = _date ?? promiseDate;
                    });
                  },
                ),
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
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: FlatButton(
                          color: Colors.red,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'CANCEL',
                          ))),
                  Spacer(flex: 1),
                  Expanded(
                      flex: 3,
                      child: FlatButton(
                          disabledColor: Colors.grey,
                          color: Theme.of(context).accentColor,
                          onPressed: (quantity > 0 &&
                                  selectedPromiseTarget != null &&
                                  selectedPromiseType != null)
                              ? () {
                                  Navigator.pop(context, {
                                    'selectedPromiseTarget':
                                        selectedPromiseTarget,
                                    'selectedPromiseType': selectedPromiseType,
                                    'quantity': quantity,
                                    'promiseDate': promiseDate
                                  });
                                }
                              : null,
                          child: Text(
                            'MAKE',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
