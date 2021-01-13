part of 'process_image_bloc.dart';

abstract class SimilarityImageState extends Equatable {
  const SimilarityImageState();

  @override
  List<Object> get props => [];
}

class ProcessImageInitial extends SimilarityImageState {}

class ProcessImageLoadingState extends SimilarityImageState {}

class ProcessImageLoadedState extends SimilarityImageState {
  final double similarity;
  final String textResult;
  final File file;

  ProcessImageLoadedState(
      {@required this.similarity,
      @required this.textResult,
      @required this.file});
}

class ProcessImageErrorState extends SimilarityImageState {
  final message;

  ProcessImageErrorState({@required this.message});
}
