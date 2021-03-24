part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();
}

class ScanReceiptEvent extends ScannerEvent {
  final File path;

  ScanReceiptEvent({
    @required this.path,
  });

  @override
  List<Object> get props => [path];
}

class SetCameraSizeEvent extends ScannerEvent {
  final Size size;

  SetCameraSizeEvent(this.size);

  @override
  List<Object> get props => [size];
}
