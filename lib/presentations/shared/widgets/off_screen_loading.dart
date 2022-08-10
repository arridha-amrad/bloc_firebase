import 'package:flutter/material.dart';

class OffScreenLoading extends StatelessWidget {
  const OffScreenLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Container(
      color: Colors.black.withAlpha(50),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
