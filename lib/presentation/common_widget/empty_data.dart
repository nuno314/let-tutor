import 'package:flutter/material.dart';

import '../extentions/extention.dart';

class EmptyData extends StatelessWidget {
  final Function()? onTap;
  final Widget? icon;

  const EmptyData({
    Key? key,
    this.onTap,
    this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? icon!
                : Icon(
                    Icons.hourglass_empty_rounded,
                    size: MediaQuery.of(context).size.width / 3,
                  ),
            const SizedBox(height: 8),
            Text(
              translate(context).noData,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
