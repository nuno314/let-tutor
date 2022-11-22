import 'package:flutter/cupertino.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

class Loading extends StatelessWidget {
  final Brightness brightness;
  final double radius;

  const Loading({
    Key? key,
    this.brightness = Brightness.dark,
    this.radius = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(brightness: brightness),
      child: CupertinoActivityIndicator(
        radius: radius,
      ),
    );
  }
}
