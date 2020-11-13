import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/presenter/home/cubit/home_cubit.dart';
import 'package:food_promise/app/shared/widgets/avatar_widget.dart';

class HomeDrawer extends StatelessWidget {
  final _cubit = Modular.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<HomeCubit>(),
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoaded) {
                        final imageUrl = state.user.imageUrl;

                        return AvatarWidget(
                          name: state.user.name,
                          imageUrl: imageUrl,
                        );
                      }
                      return Container();
                    },
                  ),
                  Spacer(),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) =>
                        Text(state is HomeLoaded ? state.user.name : ''),
                  ),
                  Spacer(),
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Modular.to.pushNamed('/home/contacts');
              },
              leading: Icon(Icons.people),
              title: Text('Contacts'),
            )
          ]
            ..add(Spacer())
            ..add(Material(
              color: Colors.white,
              child: InkWell(
                onTap: () => Future.delayed(
                    Duration(milliseconds: 200), () => _cubit.signOut()),
                child: ListTile(
                  leading:
                      Icon(Icons.close, color: Theme.of(context).primaryColor),
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            )),
        ),
      ),
    );
  }
}
