import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:go_router/go_router.dart';
import 'package:rtsp_test_app/bloc/cameraBloc.dart';

/// Реализация виджета карточки в зависимости от камеры
class CameraCard extends StatelessWidget {
  final CameraTrigger camera;
  final VlcPlayerController controller;
  const CameraCard({super.key, required this.camera, required this.controller});

  @override
  Widget build(BuildContext context) {
    switch (camera) {
      case CameraTrigger.firstCamera:
        return _BaseCameraCard(
            camera: camera, name: 'Камера 1', controller: controller);
      case CameraTrigger.secondCamera:
        return _BaseCameraCard(
            camera: camera, name: 'Камера 2', controller: controller);
      default:
        return Container();
    }
  }
}

// Базовый виджет камеры
class _BaseCameraCard extends StatelessWidget {
  final CameraTrigger camera;
  final VlcPlayerController controller;
  final String name;
  const _BaseCameraCard(
      {required this.camera, required this.controller, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: GoRouterState.of(context).name == 'Camera'
          ? () {
              context.pop();
            }
          : () {
              context.read<CameraBloc>().add(ZoomInCameraEvent(camera: camera));
              cameraCompleter.future
                  .then((value) => context.pushNamed('Camera'));
            },
      child: Card(
        color: Colors.blueGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: VlcPlayer(
                  virtualDisplay: false,
                  controller: controller,
                  aspectRatio: 1.22,
                  placeholder: const PlaceHolderCamera(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlaceHolderCamera extends StatelessWidget {
  const PlaceHolderCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).width,
      child: const CircularProgressIndicator.adaptive(
          backgroundColor: Colors.pink),
    );
  }
}
