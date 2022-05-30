import 'package:flutter/material.dart';

class FooterLoading extends StatelessWidget {
  final bool isLoading;

  const FooterLoading({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return const SizedBox.shrink();
    }

    return const SizedBox(
      height: 40,
      width: 40,
      child: CircularProgressIndicator(
        color: Colors.green,
      ),
    );
  }
}
