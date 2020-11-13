import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/widgets/home_body.dart';
import 'package:food_promise/app/modules/home/widgets/home_drawer.dart';
import 'package:food_promise/app/shared/widgets/simple_loader_widget.dart';

import 'cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  final _cubit = Modular.get<HomeCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Modular.get<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return SimpleLoader(
              withScaffold: true,
            );
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Promises'),
            ),
            drawer: HomeDrawer(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _cubit.makePromise();
              },
              child: Icon(
                Icons.add,
                size: 32,
              ),
            ),
            body: HomeBody(),
          );
        },
      ),
    );
  }
}
