part of 'scan_ktp_bloc.dart';

abstract class ScanKtpState extends Equatable {
  const ScanKtpState();
  @override
  List<Object> get props => [];
}

class ScanKtpInitial extends ScanKtpState {
  @override
  List<Object> get props => [];
}

class ScanKtpSuccessState extends ScanKtpState{
  final KtpDataEntity userData;

  ScanKtpSuccessState({@required this.userData});
}
