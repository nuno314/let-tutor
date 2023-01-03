import 'package:flutter/material.dart';
import 'package:let_tutor/generated/assets.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Image.asset(
          Assets.image.imgLogin,
          width: MediaQuery.of(context).size.width * 0.45,
        ),
      ),
    );
  }
}
