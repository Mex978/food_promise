import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/presenter/cubit/home_cubit.dart';
import 'package:food_promise/app/shared/widgets/simple_loader_widget.dart';

import '../models/promise_model.dart';

class HomeBottomSheet extends StatelessWidget {
  final _cubit = Modular.get<HomeCubit>();
  final Promise promise;
  final Function onPerformAction;

  HomeBottomSheet(
      {Key key, @required this.promise, @required this.onPerformAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if ((state as HomeLoaded).loadingBottomSheet) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SimpleLoader(
                              indicatorColor: Theme.of(context).primaryColor,
                            )
                          ],
                        );
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RaisedButton.icon(
                            icon: Icon(Icons.check),
                            label: Text('COMPLETED'),
                            onPressed: () {
                              _cubit.performPromise(promise).then((_) {
                                onPerformAction();
                                Navigator.pop(context);
                              });
                            },
                            color: Theme.of(context).primaryColor,
                          ),
                          RaisedButton.icon(
                            icon: Icon(Icons.close),
                            label: Text('CANCELED'),
                            onPressed: () {
                              _cubit.cancelPromise(promise).then((_) {
                                onPerformAction();
                                Navigator.pop(context);
                              });
                            },
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
