part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  final user = User();

  @override
  List<Object> get props => [user];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => null;
}

class HomeLoaded extends HomeState {
  final User user;
  final List<Promise> promises;
  final bool loadingBottomSheet;

  HomeLoaded({this.user, this.promises, this.loadingBottomSheet = false});
  @override
  List<Object> get props => [user, promises, loadingBottomSheet];
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
  @override
  List<Object> get props => [message];
}
