import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtsp_test_app/bloc/cameraBloc.dart';
import 'package:rtsp_test_app/ui/cameraCard.dart';

class CameraList extends StatefulWidget {
  const CameraList({super.key});

  @override
  State<CameraList> createState() => _CameraListState();
}

class _CameraListState extends State<CameraList> {
  late CameraBloc cameraBloc;

  @override
  void initState() {
    cameraBloc = context.read<CameraBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CameraCard(
                  key: const ObjectKey(CameraTrigger.firstCamera),
                  camera: CameraTrigger.firstCamera,
                  controller: cameraBloc.firstController),
              CameraCard(
                key: const ObjectKey(CameraTrigger.secondCamera),
                camera: CameraTrigger.secondCamera,
                controller: cameraBloc.secondController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
