import 'package:flutter/material.dart';

class CenteredLoading extends StatelessWidget {
  const CenteredLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
