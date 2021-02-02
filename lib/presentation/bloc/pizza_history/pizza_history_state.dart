part of 'pizza_history_bloc.dart';

abstract class PizzaHistoryState extends Equatable {
  const PizzaHistoryState();

  @override
  List<Object> get props => [];
}

class PizzaHistoryInitialState extends PizzaHistoryState {}

class PizzaHistoryLoadingState extends PizzaHistoryState {}

class PizzaHistoryLoadedState extends PizzaHistoryState {
  final List<PizzaHistoryEntity> listPizza;

  PizzaHistoryLoadedState({
    @required this.listPizza,
  });

  @override
  List<Object> get props => [
        listPizza,
      ];
}

class PizzaHistoryErrorState extends PizzaHistoryState {
  final message;
  final isShown;

  PizzaHistoryErrorState({
    @required this.message,
    @required this.isShown,
  });
}
