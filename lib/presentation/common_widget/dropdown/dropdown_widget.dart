import 'package:flutter/material.dart';

import '../../theme/theme_color.dart';

part 'dropdown_controller.dart';

class DropdownWidget<T> extends StatelessWidget {
  final String? title;
  final bool required;
  final List<T> items;
  final void Function(T?)? onChanged;
  final String? hint;
  final Widget Function(T) itemBuilder;
  final DropdownController<T, DropdownData<T>> controller;
  late final ThemeData themeData;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? prefixIconPadding;

  DropdownWidget({
    this.title,
    required this.controller,
    required this.itemBuilder,
    required this.items,
    this.onChanged,
    this.hint,
    this.required = false,
    this.prefixIcon,
    this.prefixIconPadding,
  });

  bool get hasPrefixIcon => prefixIcon != null;

  double get prefixIconSize => hasPrefixIcon ? 16 : 0;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Column(
      children: [
        if (title?.isNotEmpty == true)
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _titleText(),
              ),
              const SizedBox(height: 6),
            ],
          ),
        ValueListenableBuilder<DropdownData<T>>(
          valueListenable: controller,
          builder: (ctx, value, w) {
            return DropdownButtonFormField<T>(
              value: value.value,
              items: items.map((e) {
                return DropdownMenuItem<T>(
                  value: e,
                  child: itemBuilder(e),
                );
              }).toList(),
              onChanged: (value) {
                controller.setData(value);
                onChanged?.call(value);
              },
              iconSize: 24,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.primaryColor,
              ),
              hint: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  hint ?? '',
                  style: themeData.textTheme.titleSmall,
                ),
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.greyE5,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                errorText: value.validation,
                errorStyle: themeData.textTheme.titleMedium,
                prefixIcon: hasPrefixIcon
                    ? Padding(
                        padding: prefixIconPadding ??
                            EdgeInsets.symmetric(horizontal: prefixIconSize),
                        child: prefixIcon,
                      )
                    : null,
                prefixIconConstraints: hasPrefixIcon
                    ? BoxConstraints(
                        minHeight: prefixIconSize,
                        minWidth: prefixIconSize,
                      )
                    : null,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _titleText() {
    return Text.rich(
      TextSpan(
        text: title,
        children: <InlineSpan>[
          if (required)
            TextSpan(
              text: ' *',
              style: themeData.textTheme.bodyLarge?.copyWith(
                color: Colors.red,
              ),
            ),
        ],
        style: themeData.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
