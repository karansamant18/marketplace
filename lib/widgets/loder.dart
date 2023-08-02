import 'package:flutter/material.dart';

Future<void> showLoader(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

void hideLoder(BuildContext context) => Navigator.of(context).pop();

class CommanCircularLoader extends StatelessWidget {
  const CommanCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
