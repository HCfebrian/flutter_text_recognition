import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_text_recognition/domain/usecase/purchase_usecase.dart';
import 'package:meta/meta.dart';

part 'process_image_event.dart';

part 'process_image_state.dart';

class SimilarityImageBloc
    extends Bloc<SimilarityImageEvent, SimilarityImageState> {
  final PurchaseUsecase purchaseUsecase;

  SimilarityImageBloc({@required this.purchaseUsecase})
      : super(ProcessImageInitial());

  @override
  Stream<SimilarityImageState> mapEventToState(
    SimilarityImageEvent event,
  ) async* {
    if (event is TakeAndProcessImageEvent) {
      yield ProcessImageLoadingState();

      final result = await purchaseUsecase.getSimilarity();
      yield result.fold(
          (l) => ProcessImageErrorState(message: l.message),
          (r) => ProcessImageLoadedState(
              similarity: r.similarity, textResult: r.text, file: r.imageFile));
    }
  }
}
