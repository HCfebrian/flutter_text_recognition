import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_text_recognition/domain/usecase/purchase_scan_usecase.dart';
import 'package:meta/meta.dart';

part 'process_image_event.dart';

part 'process_image_state.dart';

class SimilarityImageBloc
    extends Bloc<SimilarityImageEvent, SimilarityImageState> {
  final PurchaseScanUsecase purchaseUsecase;

  SimilarityImageBloc({@required this.purchaseUsecase})
      : assert(purchaseUsecase != null),
        super(ProcessImageInitial());

  @override
  Stream<SimilarityImageState> mapEventToState(
    SimilarityImageEvent event,
  ) async* {
    if (event is TakeAndProcessImageEvent) {
      yield ProcessImageLoadingState();
      try {
        final result = await purchaseUsecase.getSimilarity();
        yield ProcessImageLoadedState(
            similarity: result.similarity,
            textFromDb: result.textFromDb,
            file: result.imageFile,
            textFromML: result.textFromMl, 
            isShown: false);
      } catch (e) {
        yield ProcessImageErrorState(message: e.message.toString(), isShown: true);
      }
    }
  }
}
