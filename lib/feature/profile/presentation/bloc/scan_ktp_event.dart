part of 'scan_ktp_bloc.dart';

abstract class ScanKtpEvent extends Equatable {
  const ScanKtpEvent();
}

class ScanKtpInputEvent extends ScanKtpEvent{
  final File fileImage;

  ScanKtpInputEvent({@required this.fileImage});

  @override
  List<Object> get props => [fileImage];
}