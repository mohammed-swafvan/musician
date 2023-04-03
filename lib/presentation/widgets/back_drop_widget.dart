

import 'dart:ui';
import 'package:flutter/material.dart';

class BackdropWidget extends StatelessWidget {
  const BackdropWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaY: 180,
        sigmaX: 180,
      ),
      child: Container(),
    );
  }
}
