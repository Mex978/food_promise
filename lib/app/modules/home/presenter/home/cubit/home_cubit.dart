import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_promise/app/modules/home/models/promise_model.dart';
import 'package:food_promise/app/modules/home/models/user_model.dart';
import 'package:food_promise/app/modules/home/presenter/contacts/contacts_controller.dart';
import 'package:food_promise/app/modules/home/widgets/make_new_promise_widget.dart';
import 'package:food_promise/app/shared/service/repository.dart';
import 'package:food_promise/app/shared/utils.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _repository = Modular.get<Repository>();
  final _auth = Modular.get<FirebaseAuth>();
  final _contactsController = Modular.get<ContactsController>();

  HomeCubit() : super(HomeState.initial()) {
    print('-->Criou HomeCubit<--');
    _init();
  }

  void _init() {
    getUserInfo().then((tupleUInfo) async {
      if (state is HomeInitial) emit(HomeState.loading());

      final list = await loadPromises();
      await _contactsController.init();

// TODO should handle error state here (user loaded but fails to get promises)
      if (list != null && state is HomeLoading) {
        emit(HomeState.success(
            user: User(
                uid: tupleUInfo.value1,
                email: tupleUInfo.value2,
                name: tupleUInfo.value3),
            promises: list));
      }
    });
  }

  Future<Tuple3<String, String, String>> getUserInfo() async {
    final newUid = _auth.currentUser.uid;
    final newEmail = _auth.currentUser.email;
    final userData =
        await _repository.client.collection('users').doc(newUid).get();
    final String newName = userData.data()['name'];

    return Tuple3(newUid, newEmail, newName);
  }

  Future<List<Promise>> loadPromises() async {
    emit(HomeState.loading());
    try {
      return await _repository.getPromises();
    } catch (e) {
      FoodPromiseUtils.foodPromiseDialog('Error', '$e', false);
      return null;
    }
  }

  Future reloadPromises({List<Promise> promisesLoaded, User userLoaded}) async {
    User user;
    List<Promise> promises;

    if (!(state is HomeLoading)) {
      final loadedState = (state as HomeLoaded);
      user = loadedState.user;
      promises = loadedState.promises;
    }

    final list = await loadPromises();

    emit(HomeState.success(
        user: user ?? userLoaded,
        promises: list ?? promises ?? promisesLoaded));
  }

  void makePromise({User preSelectedPromiseTarget}) async {
    final newPromise = await asuka.showDialog(
      builder: (context) => MakeNewPromiseDialog(
        preSelectedPromiseTarget: preSelectedPromiseTarget,
      ),
    );

    if (newPromise == null) {
      return;
    }

    final loadedState = (state as HomeLoaded);
    final user = loadedState.user;
    final promises = loadedState.promises;

    emit(HomeState.loading());

    final success = await _repository.createPromise(
        target: newPromise['selectedPromiseTarget'],
        type: newPromise['selectedPromiseType'],
        promiseDate: newPromise['promiseDate'],
        quantity: newPromise['quantity']);

    if (success) {
      FoodPromiseUtils.foodPromiseDialog(
          'Success', 'Promise created with success!', true);
      await reloadPromises(userLoaded: user, promisesLoaded: promises);
    } else {
      FoodPromiseUtils.foodPromiseDialog(
          'Error', 'Some error ocurred :(', false);
    }
  }

  Future performPromise(Promise promise) async {
    final loadedState = (state as HomeLoaded);
    final user = loadedState.user;
    final promises = loadedState.promises;

    emit(HomeState.success(
        user: user, promises: promises, loadingBottomSheet: true));
// TODO check if we shouldn't save the returned value
    await _repository.changePromise(promise, performed: true);

    emit(HomeState.success(
        user: user, promises: promises, loadingBottomSheet: false));
  }

  Future cancelPromise(Promise promise) async {
    final loadedState = (state as HomeLoaded);
    final user = loadedState.user;
    final promises = loadedState.promises;

    emit(HomeState.success(user: user, promises: promises, loadingBottomSheet: true));

    await _repository.changePromise(promise, cancelled: true);

    emit(HomeState.success(user: user, promises: promises, loadingBottomSheet: false));
  }

  void signOut() {
    final auth = Modular.get<FirebaseAuth>();
    auth.signOut().then((value) => Modular.to.pushReplacementNamed('/login'));
  }
}
