part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  final int index = -1;

  HomeState();

  List<Object> get props => [];
}

class HomeScreen extends HomeState {
  @override
  @override
  int get index => 0;
}

class HomeScreenSchedule extends HomeState {
  @override
  @override
  int get index => 1;
}

class HomeScreenAssignments extends HomeState {
  @override
  @override
  int get index => 2;
}
