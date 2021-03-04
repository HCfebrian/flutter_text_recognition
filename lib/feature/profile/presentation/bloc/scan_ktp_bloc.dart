import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_text_recognition/feature/profile/domain/entity/ktp_data_entity.dart';
import 'package:flutter_text_recognition/feature/profile/domain/usecase/scan_ktp_usecase.dart';
import 'package:meta/meta.dart';

part 'scan_ktp_event.dart';
part 'scan_ktp_state.dart';

class ScanKtpBloc extends Bloc<ScanKtpEvent, ScanKtpState> {
  final ScanKtpUsecase scanKtpUsecase;
  ScanKtpBloc({@required this.scanKtpUsecase}) : super(ScanKtpInitial());

  @override
  Stream<ScanKtpState> mapEventToState(
    ScanKtpEvent event,
  ) async* {
    if(event is ScanKtpInputEvent){
      yield ScanKtpInitial();
      final result = await scanKtpUsecase.getUserData(event.fileImage);
      if(result != null){
        yield ScanKtpSuccessState(userData: result);
      }
    }
  }
}
