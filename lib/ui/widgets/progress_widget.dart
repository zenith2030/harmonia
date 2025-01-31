import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var tercoTela = MediaQuery.sizeOf(context).shortestSide / 3;
    return Center(
      child: SizedBox(
        width: tercoTela,
        height: tercoTela,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
          strokeWidth: 8.0,
        ),
      ),
    );
  }
}
