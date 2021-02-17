part of 'pizza_history_bloc.dart';

abstract class PizzaHistoryEvent extends Equatable {
  const PizzaHistoryEvent();

  @override
  List<Object> get props => [];
}

class PizzaHistoryGetStreamEvent extends PizzaHistoryEvent {}

class PizzaHistoryShowList extends PizzaHistoryEvent {
  final List<PizzaHistoryEntity> listPizza;

  PizzaHistoryShowList({@required this.listPizza});
}

class PizzaHistoryDeleteEvent extends PizzaHistoryEvent {
  final documentID;

  PizzaHistoryDeleteEvent({@required this.documentID});

  @override
  List<Object> get props => [documentID];
}
