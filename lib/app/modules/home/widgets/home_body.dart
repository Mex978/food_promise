import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/presenter/home/cubit/home_cubit.dart';
import 'package:food_promise/app/modules/home/widgets/home_bottom_sheet.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

import 'promise_item_widget.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cubit = Modular.get<HomeCubit>();

    return RefreshIndicator(
      onRefresh: () => _cubit.reloadPromises(),
      child: SealedBlocBuilder4<HomeCubit, HomeState, HomeInitial, HomeLoading,
              HomeLoaded, HomeError>(
          cubit: _cubit,
          builder: (context, states) => states(
                (initial) => Container(),
                (loading) => Container(),
                (loaded) {
                  if (loaded.promises.isEmpty) {
                    return Stack(
                      children: <Widget>[
                        ListView(),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.close,
                                size: 100,
                              ),
                              Text('Nothing here yet!'),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return GridView.count(
                    padding: EdgeInsets.all(16),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: loaded.promises
                        .map((promise) => Center(
                              child: PromiseItem(
                                promise: promise,
                                onPressed: () {
                                  Future.delayed(
                                      Duration(milliseconds: 200),
                                      () => showModalBottomSheet(
                                            context: context,
                                            isDismissible: true,
                                            builder: (context) {
                                              return HomeBottomSheet(
                                                  promise: promise,
                                                  onPerformAction: () =>
                                                      _cubit.loadPromises());
                                            },
                                          ));
                                },
                              ),
                            ))
                        .toList(),
                  );
                },
                (error) => Text('${error.message}'),
              )),
    );
  }
}
