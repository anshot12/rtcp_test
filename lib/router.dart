import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtsp_test_app/bloc/cameraBloc.dart';
import 'package:rtsp_test_app/pages/camera.dart';
import 'package:rtsp_test_app/pages/cameraList.dart';

GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'CameraList',
      path: '/',
      builder: (context, state) {
        return const CameraList();
      },
    ),
    GoRoute(
        name: 'Camera',
        path: '/camera',
        onExit: (context) {
          context.read<CameraBloc>().singeCameraController.value.isInitialized
              ? context.read<CameraBloc>().singeCameraController.dispose()
              : null;
          return true;
        },
        builder: (context, state) => const CameraPage())
  ],
);
