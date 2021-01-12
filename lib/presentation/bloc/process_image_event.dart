part of 'process_image_bloc.dart';

abstract class ProcessImageEvent extends Equatable {
  const ProcessImageEvent();
  @override
  List<Object> get props => [];
}

class TakeAndProcessImageEvent extends ProcessImageEvent{}
