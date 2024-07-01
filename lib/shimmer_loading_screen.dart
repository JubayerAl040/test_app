import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as degree;

class ShimmerloadingScreen extends StatefulWidget {
  const ShimmerloadingScreen({super.key});
  @override
  State<ShimmerloadingScreen> createState() => _ShimmerloadingScreenState();
}

class _ShimmerloadingScreenState extends State<ShimmerloadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  final GlobalKey _sizeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) => _getSize());
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _colorAnimation = ColorTween(begin: Colors.white, end: Colors.white12)
        .animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Shimmer Screen"), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              _getChild(),
              Positioned(
                left: 0,
                top: -100,
                bottom: -50,
                width: 100,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) => Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateZ(degree.radians(40))
                      ..translate(size.width * _controller.value,
                          1 - (size.width * .5 * _controller.value)),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 80,
                            color: _colorAnimation.value!,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getChild() => Container(
        color: Colors.red,
        height: 120,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(height: 100, width: 100, color: Colors.grey),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20, color: Colors.grey),
                  const SizedBox(height: 10),
                  Container(height: 15, color: Colors.grey),
                  const SizedBox(height: 5),
                  Container(height: 10, width: 200, color: Colors.grey),
                  const SizedBox(height: 5),
                  Container(height: 20, width: 40, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      );

  // void _getSize() {
  //   RenderBox renderBox =
  //       _sizeKey.currentContext!.findRenderObject() as RenderBox;
  //   Size size = renderBox.size;
  //   widget.onSizeMeasured(size);
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
