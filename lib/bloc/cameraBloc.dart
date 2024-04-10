import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

abstract class CameraEvent {}

enum StateType { loaging, loaded, error }

enum CameraTrigger { firstCamera, secondCamera }

// Создаем Completer
Completer<void> cameraCompleter = Completer<void>();

class ZoomInCameraEvent extends CameraEvent {
  final CameraTrigger camera;
  ZoomInCameraEvent({required this.camera});
}

class CameraState {
  final String singelPageName;
  final CameraTrigger? camera;
  final StateType stateType;
  final PageStorageBucket backet;
  CameraState(
      {this.camera,
      required this.backet,
      required this.singelPageName,
      required this.stateType});

  CameraState copyWith(
      {CameraTrigger? camera,
      PageStorageBucket? backet,
      String? singelPageName,
      StateType? stateType}) {
    return CameraState(
      stateType: stateType ?? this.stateType,
      singelPageName: singelPageName ?? this.singelPageName,
      camera: camera ?? this.camera,
      backet: backet ?? this.backet,
    );
  }

  CameraState clean() {
    return CameraState(
        camera: null,
        backet: backet,
        singelPageName: '',
        stateType: StateType.loaded);
  }
}

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  late VlcPlayerController firstController;

  late VlcPlayerController secondController;

  late VlcPlayerController singeCameraController;

  CameraBloc()
      : super(CameraState(
          backet: PageStorageBucket(),
          singelPageName: '',
          stateType: StateType.loaded,
        )) {
    setUpControllers();
    // Переход на страницу камеры
    on<ZoomInCameraEvent>((event, emit) async {
      emit(state.copyWith(stateType: StateType.loaging));
      try {
        switch (event.camera) {
          case CameraTrigger.firstCamera:
            singeCameraController =
                VlcPlayerController.network(firstController.dataSource);
            emit(state.copyWith(
              singelPageName: 'Камера 1',
              stateType: StateType.loaded,
              camera: CameraTrigger.firstCamera,
            ));
            break;
          case CameraTrigger.secondCamera:
            singeCameraController =
                VlcPlayerController.network(secondController.dataSource);

            emit(state.copyWith(
              singelPageName: 'Камера 2',
              stateType: StateType.loaded,
              camera: CameraTrigger.secondCamera,
            ));
            break;
          default:
            emit(state.clean());
            break;
        }
        cameraCompleter.complete();
      } catch (_) {
        emit(state.copyWith(stateType: StateType.error));
      }
      emit(state.copyWith(stateType: StateType.loaded));
    });
  }

  @override
  Future<void> close() async {
    await firstController.dispose();
    await secondController.dispose();
    await singeCameraController.dispose();
    return super.close();
  }

  void setUpControllers() {
    firstController = VlcPlayerController.network(
        'rtsp://178.141.80.235:55554/Esd93HFV_s/',
        options: VlcPlayerOptions());
    secondController = VlcPlayerController.network(
        'rtsp://178.141.80.235:55555/md5IffuT_s/',
        options: VlcPlayerOptions());
  }
}
