part of 'scanner_bloc.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();
}

class ScannerInitial extends ScannerState {
  @override
  List<Object> get props => [];
}

class ScannerConfirmedState extends ScannerState{
  final int cashback;
  ScannerConfirmedState(this.cashback);
  @override
  List<Object> get props => [];
}

class ScannerNotConfirmedState extends ScannerState{
  final String message;

  ScannerNotConfirmedState(this.message);
  @override
  List<Object> get props => [message];
}