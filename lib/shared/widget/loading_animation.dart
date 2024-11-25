import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingAnimation extends StatefulWidget {
  final double dimension;
  const LoadingAnimation({required this.dimension});

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Full rotation in 1 second
    )..repeat();
  }
  
  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SvgPicture.asset(
        'assets/icons/loading-coloured.svg',
        width: widget.dimension,
        height: widget.dimension,
      ),
    );
  }
}
