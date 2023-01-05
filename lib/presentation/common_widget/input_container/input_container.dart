import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme_color.dart';

part 'input_container.controller.dart';

class InputContainer extends StatefulWidget {
  final InputContainerController? controller;
  final String? hint;
  final bool isPassword;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final void Function()? onTap;
  final void Function(String)? onTextChanged;
  final void Function(String)? onSubmitted;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final String? title;
  final TextStyle? titleStyle;
  final bool required;
  final Color? fillColor;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BorderSide? borderSide;
  final BorderSide? focusedBorderSide;
  final TextAlign textAlign;
  final int? maxLength;
  final bool showBorder;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? prefixIconPadding;
  final EdgeInsetsGeometry? suffixIconPadding;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final double prefixIconSize;
  final double suffixIconSize;
  final EdgeInsetsGeometry? titlePadding;

  const InputContainer({
    Key? key,
    this.controller,
    this.hint,
    this.isPassword = false,
    this.readOnly = false,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.onTextChanged,
    this.maxLines = 1,
    this.inputFormatters,
    this.onSubmitted,
    this.enable = true,
    this.title,
    this.titleStyle,
    this.required = false,
    this.fillColor,
    this.prefixIcon,
    this.hintStyle,
    this.textStyle,
    this.borderSide,
    this.focusedBorderSide,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.showBorder = true,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
    ),
    this.suffixIconPadding,
    this.prefixIconPadding,
    this.onEditingComplete,
    this.textInputAction,
    this.prefixIconSize = 16.0,
    this.suffixIconSize = 16.0,
    this.titlePadding,
  }) : super(key: key);

  @override
  State<InputContainer> createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  InputContainerController? _controller;

  bool get hasSuffixIcon => widget.isPassword || widget.suffixIcon != null;

  double get suffixIconSize => hasSuffixIcon ? widget.suffixIconSize : 0;

  bool get hasPrefixIcon => widget.prefixIcon != null;

  double get prefixIconSize => hasPrefixIcon ? widget.prefixIconSize : 0;

  @override
  void initState() {
    _setupController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant InputContainer oldWidget) {
    _setupController();
    super.didUpdateWidget(oldWidget);
  }

  void _setupController() {
    _controller =
        widget.controller ?? _controller ?? InputContainerController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
      _controller = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ValueListenableBuilder<InputContainerProperties>(
      valueListenable: _controller!,
      builder: (ctx, value, w) {
        Widget body;
        final textField = TextField(
          textAlign: widget.textAlign,
          focusNode: value.focusNode,
          readOnly: widget.readOnly || !widget.enable,
          controller: value.tdController,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            filled: !widget.enable || widget.fillColor != null,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
            hintText: widget.hint,
            hintStyle: widget.hintStyle ?? themeData.textTheme.subtitle2,
            errorText: value.validation,
            errorStyle: themeData.textTheme.subtitle1?.copyWith(
              color: Colors.red,
              fontSize: value.validation?.isNotEmpty == true ? null : 1,
            ),
            errorMaxLines: 2,
            suffixIcon: hasSuffixIcon
                ? Padding(
                    padding: widget.suffixIconPadding ??
                        EdgeInsets.symmetric(horizontal: suffixIconSize / 2),
                    child: _getSuffixIcon(),
                  )
                : null,
            suffixIconConstraints: hasSuffixIcon
                ? BoxConstraints(
                    minHeight: prefixIconSize,
                    minWidth: prefixIconSize,
                  )
                : null,
            prefixIcon: hasPrefixIcon
                ? Padding(
                    padding: widget.prefixIconPadding ??
                        EdgeInsets.symmetric(horizontal: prefixIconSize / 2),
                    child: widget.prefixIcon,
                  )
                : null,
            prefixIconConstraints: hasPrefixIcon
                ? BoxConstraints(
                    minHeight: prefixIconSize,
                    minWidth: prefixIconSize,
                  )
                : null,
            fillColor: widget.enable ? widget.fillColor : null,
            counterStyle: themeData.textTheme.subtitle1?.copyWith(
              color: Colors.grey,
            ),
          ),
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          style: widget.textStyle ??
              themeData.textTheme.bodyText2?.copyWith(fontSize: 14),
          obscureText:
              widget.isPassword && widget.controller?.isShowPass != true,
          onChanged: (text) {
            if (value.validation != null) {
              widget.controller?.resetValidation();
            }
            widget.onTextChanged?.call(text);
          },
          onEditingComplete: widget.onEditingComplete,
          maxLines: widget.maxLines,
          inputFormatters: widget.inputFormatters,
          onTap: widget.onTap,
          onSubmitted: widget.onSubmitted,
          textInputAction: widget.textInputAction,
        );
        if (widget.title?.isNotEmpty == true) {
          body = Column(
            children: [
              Padding(
                padding: widget.titlePadding ?? const EdgeInsets.all(0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: widget.titleStyle != null
                          ? widget.title!
                          : widget.title!.toUpperCase(),
                      style: widget.titleStyle ??
                          themeData.textTheme.bodyText1?.copyWith(
                            fontSize: 12,
                          ),
                      children: [
                        if (widget.required == true)
                          TextSpan(
                            text: ' *',
                            style: themeData.textTheme.headline6!.copyWith(
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              textField,
            ],
          );
        } else {
          body = textField;
        }

        final border = widget.showBorder
            ? OutlineInputBorder(
                borderSide: widget.borderSide ??
                    BorderSide(color: Colors.grey[300]!, width: 1),
                borderRadius: BorderRadius.circular(6.0),
              )
            : InputBorder.none;
        final focusedBorder = widget.showBorder
            ? OutlineInputBorder(
                borderSide: widget.focusedBorderSide ??
                    BorderSide(color: AppColor.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(6.0),
              )
            : InputBorder.none;
        return Theme(
          data: themeData.copyWith(
            primaryColor: themeData.colorScheme.secondary,
            primaryColorDark: themeData.colorScheme.secondary,
            inputDecorationTheme: InputDecorationTheme(
              border: border,
              enabledBorder: border,
              focusedBorder: focusedBorder,
            ),
          ),
          child: body,
        );
      },
    );
  }

  Widget? _getSuffixIcon() {
    if (widget.isPassword) {
      final icon = widget.suffixIcon ?? _getPasswordIcon();
      return InkWell(
        onTap: widget.controller!.showOrHidePass,
        child: icon,
      );
    }
    return widget.suffixIcon;
  }

  Widget _getPasswordIcon() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Icon(
        widget.controller?.isShowPass == true
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        size: 20,
        color: Colors.grey,
      ),
    );
  }
}
