part of 'process_image_bloc.dart';

abstract class SimilarityImageEvent extends Equatable {
  const SimilarityImageEvent();
  @override
  List<Object> get props => [];
}

class TakeAndProcessImageEvent extends SimilarityImageEvent{}
