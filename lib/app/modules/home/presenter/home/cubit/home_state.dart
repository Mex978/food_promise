part of 'home_cubit.dart';

@immutable
class HomeState
    extends Union4Impl<HomeInitial, HomeLoading, HomeLoaded, HomeError>
    with EquatableMixin {
  static final unions =
      const Quartet<HomeInitial, HomeLoading, HomeLoaded, HomeError>();

  HomeState._(Union4<HomeInitial, HomeLoading, HomeLoaded, HomeError> union)
      : super(union);

  factory HomeState.initial() => HomeState._(unions.first(HomeInitial()));

  factory HomeState.loading() => HomeState._(unions.second(HomeLoading()));

  factory HomeState.success(
          {User user, List<Promise> promises, loadingBottomSheet = false}) =>
      HomeState._(unions.third(HomeLoaded(
          user: user,
          promises: promises,
          loadingBottomSheet: loadingBottomSheet)));

  factory HomeState.failure({String error}) =>
      HomeState._(unions.fourth(HomeError(error)));

  @override
  List<Object> get props => [];
}

class HomeInitial extends Equatable {
  final user = User();

  @override
  List<Object> get props => [user];
}

class HomeLoading extends Equatable {
  @override
  List<Object> get props => null;
}

class HomeLoaded extends Equatable {
  final User user;
  final List<Promise> promises;
  final bool loadingBottomSheet;

  HomeLoaded({this.user, this.promises, this.loadingBottomSheet = false});
  @override
  List<Object> get props => [user, promises, loadingBottomSheet];
}

class HomeError extends Equatable {
  final String message;

  HomeError(this.message);
  @override
  List<Object> get props => [message];
}
