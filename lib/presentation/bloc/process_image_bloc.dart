import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_text_recognition/domain/usecase/purchase_usecase.dart';
import 'package:meta/meta.dart';

part 'process_image_event.dart';
part 'process_image_state.dart';

class ProcessImageBloc extends Bloc<ProcessImageEvent, ProcessImageState> {
  final PurchaseUsecase purchaseUsecase;
  ProcessImageBloc({@required this.purchaseUsecase}) : super(ProcessImageInitial());
  @override
  Stream<ProcessImageState> mapEventToState(
    ProcessImageEvent event,
  ) async* {

    if(event is TakeAndProcessImageEvent){
        final result = await  purchaseUsecase.getSimilarity();
        result.fold((l) => null, (r) => null);
    }

  }
}
