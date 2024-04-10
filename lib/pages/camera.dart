import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:rtsp_test_app/bloc/cameraBloc.dart';
import 'package:rtsp_test_app/ui/cameraCard.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: Colors.grey,
      body: BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) {
          if (state.stateType == StateType.loaded) {
            return Center(
                child: CameraCard(
              key: const ObjectKey('single'),
              camera: state.camera!,
              controller: context.read<CameraBloc>().singeCameraController,
            ));
          } else {
            return const Center(child: PlaceHolderCamera());
          }
        },
      ),
    );
  }
}
