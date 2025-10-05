import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Car3DDemoWidget extends StatefulWidget {
  final String? modelUrl;

  const Car3DDemoWidget({super.key, this.modelUrl});

  @override
  State<Car3DDemoWidget> createState() => _Car3DDemoWidgetState();
}

class _Car3DDemoWidgetState extends State<Car3DDemoWidget>
    with SingleTickerProviderStateMixin {
  final Flutter3DController _flutter3DController = Flutter3DController();
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 360).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    _rotationAnimation.addListener(() {
      _flutter3DController.setCameraOrbit(_rotationAnimation.value, 75, 90);
      _flutter3DController.setCameraTarget(0, 0, 0);
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

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
          src: widget.modelUrl ?? 'assets/3d/car1.glb',
          controller: _flutter3DController,
          progressBarColor: Colors.transparent,
          onLoad: (sceneName) async {
            // Start rotation after load
            _rotationController.repeat();
          },
        ),
      ],
    );
  }
}
