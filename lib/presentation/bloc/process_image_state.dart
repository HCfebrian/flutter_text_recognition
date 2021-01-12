part of 'process_image_bloc.dart';

abstract class ProcessImageState extends Equatable {
  const ProcessImageState();

  @override
  List<Object> get props => [];
}

class ProcessImageInitial extends ProcessImageState {}

class ProcessImageLoadingState extends ProcessImageState {}

class ProcessImageLoadedState extends ProcessImageState {
  final double similarity;
  final String testResut;
  final File file;

  ProcessImageLoadedState(
      {@required this.similarity,
      @required this.testResut,
      @required this.file});
}

class ProcessImageErrorState extends ProcessImageState {
  final message;

  ProcessImageErrorState({@required this.message});
}
