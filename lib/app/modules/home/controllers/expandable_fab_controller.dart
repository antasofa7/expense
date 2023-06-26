// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ExpandableFabController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   var initialOpen = false.obs;
//   var distance = 0.0.obs;
//   var children = <Widget>[].obs;
//   late final AnimationController _controller;
//   late final Animation<double> expandAnimation;

//   var open = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     open(initialOpen.value);
//     _controller = AnimationController(
//         vsync: this,
//         value: open.value ? 1.0 : 0.0,
//         duration: const Duration(milliseconds: 250));
//     expandAnimation = CurvedAnimation(
//         parent: _controller,
//         curve: Curves.fastOutSlowIn,
//         reverseCurve: Curves.easeInOutQuad);
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     _controller.dispose();
//   }

//   void toggle() {
//     open(!open.value);

//     if (open.value) {
//       _controller.forward();
//     } else {
//       _controller.reverse();
//     }
//   }
// }
