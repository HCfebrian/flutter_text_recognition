part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();
}

class ScanReceiptEvent extends ScannerEvent {
  final File path;
  final Size size;

  ScanReceiptEvent({
    @required this.path,
    @required this.size,
  });

  @override
  List<Object> get props => [path, size];
}

class SetCameraSizeEvent extends ScannerEvent {
  final Size size;

  SetCameraSizeEvent(this.size);

  @override
  List<Object> get props => [size];
}
