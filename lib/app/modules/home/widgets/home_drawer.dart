import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/presenter/home/cubit/home_cubit.dart';
import 'package:food_promise/app/shared/widgets/avatar_widget.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

class HomeDrawer extends StatelessWidget {
  final _cubit = Modular.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  SealedBlocBuilder4<HomeCubit, HomeState, HomeInitial,
                      HomeLoading, HomeLoaded, HomeError>(
                    cubit: _cubit,
                    builder: (context, states) => states(
                      (initial) => Container(),
                      (loading) => Container(),
                      (loaded) {
                        final imageUrl = loaded.user.imageUrl;

                        return AvatarWidget(
                          name: loaded.user.name,
                          imageUrl: imageUrl,
                        );
                      },
                      (error) => Container(),
                    ),
                  ),
                  Spacer(),
                  SealedBlocBuilder4<HomeCubit, HomeState, HomeInitial,
                      HomeLoading, HomeLoaded, HomeError>(
                    cubit: _cubit,
                    builder: (context, states) => states(
                        (initial) => Container(),
                        (loading) => Container(),
                        (loaded) => Text(loaded.user.name),
                        (error) => Container()),
                  ),
                  Spacer(),
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ]),
    );
  }
}
