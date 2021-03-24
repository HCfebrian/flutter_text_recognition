import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_text_recognition/feature/history/domain/usecase/purchase_scan_usecase.dart';
import 'package:meta/meta.dart';

part 'scanner_event.dart';

part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final PurchaseScanUsecase purchaseScanUsecase;

  ScannerBloc({@required this.purchaseScanUsecase}) : super(ScannerInitial());

  @override
  Stream<ScannerState> mapEventToState(
    ScannerEvent event,
  ) async* {
    if (event is SetCameraSizeEvent) {
      purchaseScanUsecase.setSize(event.size);
    }

    if (event is ScanReceiptEvent) {
      yield ScannerInitial();
      try {
        final result =
            await purchaseScanUsecase.getSimilarity(sourceFile: event.path);
        if (result.confirmed) {
          yield ScannerConfirmedState(result.cashback);
        } else {
          yield ScannerNotConfirmedState("cannot confirm this receipt");
        }
      } catch (e) {
        if (e.message == "Camera Fail") {
          print(e.message);
        } else {
          yield (ScannerNotConfirmedState(e.message));
        }
      }
    }
  }
}
