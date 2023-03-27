import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/utils.dart';
import '../../../generated/assets.dart';
import '../../theme/theme_color.dart';
import '../export.dart';

class DropdownLanguageArgs {
  String title;
  String iconPath;
  DropdownLanguageArgs({
    required this.title,
    required this.iconPath,
  });
}

class ScreenForm extends StatefulWidget {
  final String? title;
  final String? des;
  final Widget? child;
  final Color? bgColor;
  final Color? headerColor;
  final bool showHeaderImage;
  final List<Widget> actions;
  final void Function()? onBack;
  final bool? resizeToAvoidBottomInset;
  final Widget? extentions;
  final bool showBackButton;
  final dynamic trans;
  final Widget? floatingActionButton;

  const ScreenForm({
    Key? key,
    this.title,
    this.des,
    this.child,
    this.bgColor,
    this.showHeaderImage = true,
    this.actions = const <Widget>[],
    this.headerColor,
    this.onBack,
    this.resizeToAvoidBottomInset,
    this.extentions,
    this.showBackButton = true,
    this.floatingActionButton,
    required this.trans,
  }) : super(key: key);

  @override
  _ScreenFormState createState() => _ScreenFormState();
}

class _ScreenFormState extends State<ScreenForm> with AfterLayoutMixin {
  late ThemeData _theme;
  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.showHeaderImage) {
      AppColor.setDarkStatusBar();
    } else {
      AppColor.setLightStatusBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final padding = mediaQueryData.padding;

    final main = Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: padding.top - 20),
          color: widget.headerColor ?? Colors.transparent,
          child: _buildAppBar(),
        ),
        Expanded(
          child: widget.child ?? const SizedBox(),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: widget.bgColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      body: GestureDetector(
        onTap: () => CommonFunction.hideKeyBoard(context),
        child: main,
      ),
    );
  }

  Widget _buildAppBar() {
    final textColor = widget.showHeaderImage == true
        ? Colors.white
        : widget.headerColor != null
            ? Colors.white
            : Colors.black;

    final desTextColor =
        widget.showHeaderImage == true ? Colors.white.withOpacity(0.7) : null;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: widget.showBackButton ? 4 : 16),
            if (widget.showBackButton)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: IconButton(
                  onPressed: widget.onBack ?? () => Navigator.pop(context),
                  icon: Icon(
                    Icons.chevron_left_outlined,
                    size: 18,
                    color: textColor,
                  ),
                ),
              ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  right: widget.actions.isEmpty ? 24 : 8,
                  top: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.showHeaderImage)
                      SvgPicture.asset(
                        Assets.svg.icLogo,
                        height: 40,
                      ),
                    if (widget.title != null) ...[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.title!,
                        style: _theme.textTheme.displaySmall?.copyWith(
                          color: textColor,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                    ],
                    if (widget.des?.isNotEmpty == true) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.des ?? '',
                        style: _theme.textTheme.titleSmall?.copyWith(
                          color: desTextColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            ...widget.actions,
          ],
        ),
        if (widget.extentions != null) widget.extentions!,
      ],
    );
  }
}
