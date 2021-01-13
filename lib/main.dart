
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_text_recognition/injection_container.dart';

import 'presentation/bloc/bloc_similarity_image/process_image_bloc.dart';
import 'presentation/pages/purchase_page.dart';
import 'injection_container.dart' as di;
import 'presentation/pages/purchase_screen.dart';


Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MaterialApp(
    home: MultiBlocProvider(
      providers: [
        BlocProvider<SimilarityImageBloc>(
          create: (BuildContext context) => SimilarityImageBloc(purchaseUsecase: sl()),
        ),
      ],
      child: PurchaseScreen(),
    )
    ,
  ));
}

