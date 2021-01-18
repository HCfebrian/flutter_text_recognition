import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_text_recognition/presentation/bloc/bloc_similarity_image/process_image_bloc.dart';
import 'package:flutter_text_recognition/presentation/widget/purchase_content.dart';

class PurchaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi There, scan your receipt"),
      ),
      body: BlocBuilder<SimilarityImageBloc, SimilarityImageState>(
        builder: (context, state) {
          if (state is ProcessImageInitial) {
            return PurchaseScreenContent(
              textFromDb: "no image, no text!",
              similarity: 0,
              fileImage: null,
              textFromMl: "no ml text yet",
              isShown: false,
            );
          }

          if (state is ProcessImageLoadingState) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is ProcessImageLoadedState) {
            return PurchaseScreenContent(
              textFromDb: state.textFromDb,
              similarity: state.similarity,
              fileImage: state.file,
              textFromMl: state.textFromML,
              isShown: state.isShown,
            );
          }
          // this is error state
          return Container(
            child: Center(
              child:
                  Text((state as ProcessImageErrorState).message ?? "error!"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.photo_camera),
        onPressed: () {
          BlocProvider.of<SimilarityImageBloc>(context)
              .add(TakeAndProcessImageEvent());
        },
      ),
    );
  }
}
