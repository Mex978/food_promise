import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/presenter/cubit/home_cubit.dart';
import 'package:food_promise/app/modules/home/widgets/home_bottom_sheet.dart';

import 'promise_item_widget.dart';

class HomeBody extends StatelessWidget {
  final _cubit = Modular.get<HomeCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: RefreshIndicator(
        onRefresh: () => _cubit.reloadPromises(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              if (state.promises.isEmpty) {
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
                children: state.promises
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
            }
            return Container();
          },
        ),
      ),
    );
  }
}
