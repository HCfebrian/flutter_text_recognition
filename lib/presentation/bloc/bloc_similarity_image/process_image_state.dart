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
  final String textFromDb;
  final String textFromML;
  final bool isShown;
  final File file;

  ProcessImageLoadedState({
    @required this.similarity,
    @required this.textFromDb,
    @required this.file,
    @required this.textFromML,
    @required this.isShown,
  });
}

class ProcessImageErrorState extends SimilarityImageState {
  final message;
  final isShown;

  ProcessImageErrorState({
    @required this.message,
    @required this.isShown,
  });
}
