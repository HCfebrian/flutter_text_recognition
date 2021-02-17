import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/feature/history/domain/entity/pizza_entity.dart';
import 'package:flutter_text_recognition/feature/history/domain/usecase/order_history_usecase.dart';
import 'package:meta/meta.dart';


part 'pizza_history_event.dart';

part 'pizza_history_state.dart';

class PizzaHistoryBloc extends Bloc<PizzaHistoryEvent, PizzaHistoryState> {
  final OrderHistoryUsecase orderUsecase;

  PizzaHistoryBloc(this.orderUsecase) : super(PizzaHistoryInitialState());

  Stream<List<PizzaHistoryEntity>> listener;

  @override
  Stream<PizzaHistoryState> mapEventToState(
    PizzaHistoryEvent event,
  ) async* {
    if (event is PizzaHistoryGetStreamEvent) {
      if (listener == null) {
        yield PizzaHistoryLoadingState();
        listener = orderUsecase.getPizzaHistory();
        orderUsecase.getPizzaHistory()?.listen((event) {
          print("event.length");
          print(event.length);
          print(event[1].pizzaName);
          add(PizzaHistoryShowList(listPizza: event));
        });
      }
    }

    if (event is PizzaHistoryShowList) {
      yield PizzaHistoryLoadedState(listPizza: event.listPizza);
    }

    if(event is PizzaHistoryDeleteEvent){
      orderUsecase.deletePizzaHistory(documentID: event.documentID);
    }
  }
}
