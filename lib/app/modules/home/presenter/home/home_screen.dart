import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/widgets/home_body.dart';
import 'package:food_promise/app/modules/home/widgets/home_drawer.dart';
import 'package:food_promise/app/shared/widgets/simple_loader_widget.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

import 'cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  final _cubit = Modular.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return SealedBlocBuilder4<HomeCubit, HomeState, HomeInitial, HomeLoading,
        HomeLoaded, HomeError>(
      cubit: Modular.get<HomeCubit>(),
      builder: (BuildContext context, states) => states(
          (initial) => SimpleLoader(
                withScaffold: true,
              ),
          (loading) => SimpleLoader(
                withScaffold: true,
              ),
          (loaded) => Scaffold(
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
              ),
          (error) => Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text('Error'),
                ),
                body: Column(
                  children: [
                    Text('${error.message}'),
                  ],
                ),
              )),
    );
  }
}
