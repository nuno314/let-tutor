import 'dart:math';

import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/modules/app.dart';

import 'shadow.dart';
import 'theme_color.dart';

class ThemeButton {
  ThemeButton._();
  static TextStyle? getTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.button;
  }

  static TextStyle? getTextStyleNormal(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColor.primaryText,
        );
  }

  static Widget primary({
    required BuildContext context,
    required String title,
    Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
    BoxConstraints constraints = const BoxConstraints(minHeight: 48.0),
    bool enable = true,
    double radius = 8,
    Widget? prefixIcon,
  }) =>
      RawMaterialButton(
        fillColor: enable
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withAlpha(55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        onPressed: enable ? onPressed : null,
        elevation: 0,
        padding: padding,
        constraints: constraints,
        child: RichText(
          text: TextSpan(
            style: getTextStyle(context)!.copyWith(
              color: Colors.white,
            ),
            children: [
              if (prefixIcon != null)
                WidgetSpan(
                  child: prefixIcon,
                  alignment: PlaceholderAlignment.middle,
                ),
              TextSpan(
                text: title,
                style: getTextStyle(context)!.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
          textAlign: TextAlign.center,
        ),
      );

  static Widget primaryIcon({
    required BuildContext context,
    required String title,
    required Widget icon,
    Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 15,
    ),
    BoxConstraints constraints = const BoxConstraints(minHeight: 48.0),
  }) =>
      RawMaterialButton(
        fillColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: onPressed,
        elevation: 0,
        padding: padding,
        constraints: constraints,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                title,
                style: getTextStyle(context)?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 6),
            icon,
          ],
        ),
      );

  static Widget notRecommend({
    required BuildContext context,
    String title = '',
    Function()? onPressed,
    double btnRadius = 8,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
    BoxConstraints constraints = const BoxConstraints(minHeight: 48.0),
    TextStyle? textStyle,
    Color? fillColor,
    bool enable = true,
  }) =>
      RawMaterialButton(
        fillColor: fillColor ?? AppColor.grayAD,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(btnRadius),
          side: BorderSide(
            color: AppColor.transparent,
            width: 1,
          ),
        ),
        onPressed: onPressed,
        elevation: 0,
        padding: padding,
        constraints: constraints,
        child: Text(
          title,
          style: getTextStyle(context)?.copyWith(
            color: enable ? AppColor.white : AppColor.greyE5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      );

  static Widget recommend({
    required BuildContext context,
    required String title,
    Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
    BoxConstraints constraints = const BoxConstraints(minHeight: 40.0),
    TextStyle? textStyle,
    bool enable = true,
  }) {
    return ThemeButton.primary(
      context: context,
      title: title,
      onPressed: onPressed,
      padding: padding,
      constraints: constraints,
      enable: enable,
    );
  }

  static Widget bottomButton(
    BuildContext context, {
    String? title,
    Widget? titleWidget,
    String? content,
    String? description,
    String? buttonTitle,
    Function()? onTap,
    List<Widget>? buttons,
    bool isWithShadown = true,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
  }) {
    final theme = Theme.of(context);
    final paddingBottom = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        boxShadow: isWithShadown ? boxShadowlight : null,
        color: isWithShadown ? AppColor.white : AppColor.transparent,
        borderRadius: borderRadius,
      ),
      padding: padding ??
          const EdgeInsets.all(16).copyWith(bottom: max(paddingBottom, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title?.isNotEmpty == true ||
              content?.isNotEmpty == true ||
              description?.isNotEmpty == true)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title?.isNotEmpty == true || content?.isNotEmpty == true)
                  Row(
                    children: [
                      if (title?.isNotEmpty == true)
                        Text(
                          title ?? '',
                          style: theme.textTheme.bodyText1?.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      const SizedBox(
                        width: 8,
                      ),
                      if (titleWidget != null) titleWidget,
                      if (content?.isNotEmpty == true)
                        Expanded(
                          child: Text(
                            content ?? '',
                            style: theme.textTheme.bodyText1?.copyWith(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                    ],
                  ),
                if (description?.isNotEmpty == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        '* $description',
                        style: theme.textTheme.subtitle1?.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          buttons?.isNotEmpty == true
              ? Builder(builder: (context) {
                  final widgets = <Widget>[];

                  for (final button in buttons!) {
                    widgets.add(Expanded(child: button));

                    if (buttons.indexOf(button) != buttons.length - 1) {
                      widgets.add(const SizedBox(
                        width: 16,
                      ));
                    }
                  }

                  return Row(
                    children: widgets,
                  );
                })
              : ThemeButton.primary(
                  context: context, title: buttonTitle ?? '', onPressed: onTap),
        ],
      ),
    );
  }

  static Widget deny({
    required BuildContext context,
    String title = '',
    Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
    BoxConstraints constraints = const BoxConstraints(minHeight: 48.0),
    bool? reverseColor,
  }) =>
      RawMaterialButton(
        fillColor: reverseColor == true ? Colors.red : const Color(0xffFFF0F1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: onPressed,
        elevation: 0,
        constraints: constraints,
        child: Text(
          title,
          style: getTextStyle(context)!.copyWith(
            color: reverseColor == true ? AppColor.white : Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      );

  static Widget customColor({
    required BuildContext context,
    required String title,
    Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
    BoxConstraints constraints = const BoxConstraints(minHeight: 48.0),
    bool enable = true,
    Color bgBtnColor = Colors.white,
    Color? textColor,
    BorderRadiusGeometry? borderRadius,
    Color? borderColor,
  }) =>
      RawMaterialButton(
        fillColor: enable ? bgBtnColor : Colors.grey[400],
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          side: BorderSide(
            color: borderColor ?? AppColor.primaryColor,
            width: 1,
          ),
        ),
        onPressed: enable ? onPressed : null,
        elevation: 0,
        padding: padding,
        constraints: constraints,
        child: Text(
          title,
          style: getTextStyle(context)!.copyWith(
            color: textColor ?? AppColor.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      );
  static Widget outline({
    required BuildContext context,
    required String title,
    void Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
    BoxConstraints constraints = const BoxConstraints(minHeight: 48.0),
    bool enable = true,
    Color bgBtnColor = Colors.white,
    Color? textColor,
    BorderRadiusGeometry? borderRadius,
    Color? borderColor,
  }) =>
      RawMaterialButton(
        fillColor: enable ? bgBtnColor : Colors.grey[400],
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          side: BorderSide(
            color: borderColor ?? AppColor.primaryColor,
            width: 1,
          ),
        ),
        onPressed: enable ? onPressed : null,
        elevation: 0,
        padding: padding,
        constraints: constraints,
        child: Text(
          title,
          style: getTextStyle(context)!.copyWith(
            color: textColor ?? AppColor.primaryColor,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      );

  static Widget text({
    required BuildContext context,
    required String title,
    Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
    BoxConstraints constraints = const BoxConstraints(minHeight: 36.0),
    bool enable = true,
    Color bgBtnColor = Colors.transparent,
    Color? textColor,
    BorderRadiusGeometry? borderRadius,
    double? fontSize,
    TextStyle? textStyle,
  }) =>
      RawMaterialButton(
        fillColor: bgBtnColor,
        onPressed: enable ? onPressed : null,
        elevation: 0,
        padding: padding,
        constraints: constraints,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text(
          title,
          style: (textStyle ?? getTextStyle(context))!.copyWith(
            fontSize: fontSize,
            color: enable ? (textColor ?? Colors.black) : Colors.grey[400],
          ),
          textAlign: TextAlign.center,
        ),
      );
}
