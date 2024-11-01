import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        color: Colors.grey[200]!.withOpacity(0.4),
        child: Center(
          child: SpinKitThreeBounce(
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
