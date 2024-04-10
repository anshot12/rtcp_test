import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rtsp_test_app/bloc/cameraBloc.dart';
import 'package:rtsp_test_app/router.dart';

void main() {
  runApp(BlocProvider<CameraBloc>.value(
      value: CameraBloc(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
