import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Car3DDemoWidget extends StatefulWidget {
  const Car3DDemoWidget({super.key});

  @override
  State<Car3DDemoWidget> createState() => _Car3DDemoWidgetState();
}

class _Car3DDemoWidgetState extends State<Car3DDemoWidget> {
  final Flutter3DController _flutter3DController = Flutter3DController();

  void cameraStep() {
    _flutter3DController.setCameraOrbit(-100, 88, 500);
    _flutter3DController.setCameraTarget(-150, 0, -20);
  }

  void cameraTop() {
    _flutter3DController.setCameraOrbit(0, 0, 80);
    _flutter3DController.setCameraTarget(0, 0, 80);
  }

  void cameraLeft() {
    _flutter3DController.setCameraOrbit(-135, 80, 90);
    _flutter3DController.setCameraTarget(35, 0, 0);
  }

  void cameraBackLeft() {
    _flutter3DController.setCameraOrbit(-400, 80, 90);
    _flutter3DController.setCameraTarget(35, 0, 0);
  }

  void cameraRight() {
    _flutter3DController.setCameraOrbit(135, 80, 90);
    _flutter3DController.setCameraTarget(-35, 0, 0);
  }

  void cameraBackRight() {
    _flutter3DController.setCameraOrbit(400, 80, 90);
    _flutter3DController.setCameraTarget(-35, 0, 0);
  }

  void cameraFront() {
    _flutter3DController.setCameraOrbit(180, 75, 80);
    _flutter3DController.setCameraTarget(0, 0, 0);
  }

//work for car1 1
  void cameraBack() {
    _flutter3DController.setCameraOrbit(-35, 75, 90);
    _flutter3DController.setCameraTarget(0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Flutter3DViewer(
          src: 'assets/3d/car1.glb',
          // src: 'assets/3d/tesla_2018_model_3.glb',
          controller: _flutter3DController,
          progressBarColor: Colors.transparent,
          onLoad: (sceneName) async {
            cameraBack();
          },
        ),
      ],
    );
  }
}
