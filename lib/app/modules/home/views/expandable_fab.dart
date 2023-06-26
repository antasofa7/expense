import 'dart:math' as math;

import 'package:expense/app/constants/assets.dart';
import 'package:expense/app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExpandableFab extends StatefulWidget {
  final bool? initialOpen;
  final double distance;
  final List<Widget> children;
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  bool _open = false;
  double turn = 0.0;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
        vsync: this,
        value: _open ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250));
    _expandAnimation = CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.easeInOutQuad);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      turn += 1.0 / 8.0;

      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        // _buildTapToCloseFab(),
        ..._buildExpandingActionButton(),
        _buildTapToOpenFab()
      ],
    );
  }

  // Widget _buildTapToCloseFab() {
  //   return SizedBox(
  //     height: 56.0,
  //     width: 56.0,
  //     child: Center(
  //       child: Material(
  //           shape: const CircleBorder(),
  //           // color: greenColor,
  //           clipBehavior: Clip.antiAlias,
  //           elevation: 4,
  //           child: InkWell(
  //             onTap: _toggle,
  //             child: const Padding(
  //               padding: EdgeInsets.all(8.0),
  //               child: Icon(Icons.close),
  //             ),
  //             // child: SvgPicture.asset(
  //             //   Assets.income,
  //             // ),
  //           )),
  //     ),
  //   );
  // }

  List<Widget> _buildExpandingActionButton() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);

    for (var i = 0, angleInDegrees = 45.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(_ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: i == 1 ? widget.distance + 40 : widget.distance,
          progress: _expandAnimation,
          child: widget.children[i]));
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return AnimatedRotation(
      turns: turn,
      duration: const Duration(milliseconds: 250),
      child: FloatingActionButton(
        onPressed: _toggle,
        elevation: 0,
        backgroundColor: primaryColor,
        child: SvgPicture.asset(Assets.add),
      ),
    );
    // return IgnorePointer(
    //     ignoring: _open,
    //     child: AnimatedContainer(
    //       transformAlignment: Alignment.center,
    //       transform: Matrix4.diagonal3Values(
    //           _open ? 0.7 : 1.0, _open ? 0.7 : 1.0, 1.0),
    //       duration: const Duration(milliseconds: 250),
    //       curve: const Interval(0.25, 1.0, curve: Curves.easeOut),
    //       child: AnimatedOpacity(
    //         opacity: _open ? 0.0 : 1.0,
    //         duration: const Duration(milliseconds: 250),
    //         curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
    //         child: FloatingActionButton(
    //           onPressed: _toggle,
    //           backgroundColor: primaryColor,
    //           child: SvgPicture.asset(Assets.add),
    //         ),
    //       ),
    //     ));
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  const _ExpandingActionButton(
      {required this.directionInDegrees,
      required this.maxDistance,
      required this.progress,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
            directionInDegrees * (math.pi / 180.0),
            progress.value * maxDistance);
        return Positioned(
            right: 4.0 + offset.dx,
            left: 4.0 - offset.dx,
            bottom: 4.0 + offset.dy,
            child: Transform.rotate(
              angle: (1.0 - progress.value) * math.pi / 2,
              child: child!,
            ));
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final Color color;
  const ActionButton(
      {super.key, this.onPressed, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: color,
      elevation: 4,
      child: IconButton(
        padding: const EdgeInsets.all(12.0),
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
