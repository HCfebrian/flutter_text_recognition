part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();
}

class ScanReceiptEvent extends ScannerEvent{
  @override
  List<Object> get props => [];
}
