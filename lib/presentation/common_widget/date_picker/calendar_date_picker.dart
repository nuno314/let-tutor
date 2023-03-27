import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../common/utils.dart';
import '../../theme/theme_color.dart';
import '../box_color.dart';
import '../expandable_widget.dart';

class DateInputCalendarPicker extends StatefulWidget {
  final void Function()? onTapInputField;
  final void Function(DateTime date) onDateSelected;
  final DateTime? initial;
  final String monthStr;
  final String title;
  final String? hint;
  final String calendarIcon;
  final DateTime? minDate;
  final DateTime? maxDate;

  const DateInputCalendarPicker({
    Key? key,
    this.onTapInputField,
    required this.onDateSelected,
    this.initial,
    required this.monthStr,
    required this.title,
    required this.calendarIcon,
    this.hint,
    this.minDate,
    this.maxDate,
  }) : super(key: key);

  @override
  State<DateInputCalendarPicker> createState() =>
      _DateInputCalendarPickerState();
}

class _DateInputCalendarPickerState extends State<DateInputCalendarPicker> {
  DateTime? select;

  final _expandableCtrl = ExpandableController();

  @override
  void initState() {
    select = widget.initial;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DateInputCalendarPicker oldWidget) {
    select = widget.initial;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    select = widget.initial;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _expandableCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return ExpandableWidget(
      onTapHeader: () {
        widget.onTapInputField?.call();
      },
      header: _buildDateInputField(textTheme: textTheme),
      body: TableCalendarDatePicker(
        monthStr: widget.monthStr,
        context: context,
        value: select,
        minDate: widget.minDate,
        maxDate: widget.maxDate,
        onSelected: (date) {
          _expandableCtrl.toggle();
          if (mounted) {
            setState(() {
              select = date;
            });
          }
          widget.onDateSelected(date);
        },
      ),
      textTheme: textTheme,
      controller: _expandableCtrl,
    );
  }

  Widget _buildDateInputField({
    required TextTheme textTheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 8,
          ),
          child: Text(
            widget.title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        HighlightBoxColor(
          borderColor: Colors.grey,
          padding: const EdgeInsets.all(12),
          bgColor: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  select?.toNormalDateFormat() ?? widget.hint ?? '',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                    color:
                        select != null ? Colors.black : AppColor.subText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(
                widget.calendarIcon,
                width: 24,
                height: 24,
                color: AppColor.primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TableCalendarDatePicker extends StatelessWidget {
  const TableCalendarDatePicker({
    Key? key,
    required this.monthStr,
    required this.context,
    required this.value,
    required this.onSelected,
    this.minDate,
    this.maxDate,
  }) : super(key: key);

  final String monthStr;
  final BuildContext context;
  final DateTime? value;
  final DateTime? minDate;
  final DateTime? maxDate;
  final void Function(DateTime selected) onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final dateLocale = context.appDateLocale;
    return TableCalendar(
      firstDay: DateTime.utc(2000, 01, 01),
      lastDay: DateTime.utc(2099, 12, 31),
      focusedDay: value ?? DateTime.now(),
      currentDay: value ?? DateTime.now(),
      availableCalendarFormats: {
        CalendarFormat.month: monthStr,
      },
      locale: Localizations.localeOf(context).languageCode,
      onDaySelected: (selectedDay, _) {
        onSelected.call(selectedDay);
      },
      enabledDayPredicate: (day) {
        var check1 = true;
        var check2 = true;
        if (minDate != null) {
          check1 = day.isAfter(minDate!);
        }

        if (maxDate != null) {
          check2 = day.isBefore(maxDate!);
        }
        return check1 && check2;
      },
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonDecoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(22.0),
        ),
        formatButtonTextStyle: const TextStyle(color: Colors.white),
        formatButtonShowsNext: false,
        titleTextFormatter: (date, locale) => date.customFormat(
          ['$monthStr ', 'mm', ', ', 'yyyy'],
        ),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          return Center(
            child: Text(
              dateLocale.daysShort[day.weekday - 1],
              style: textTheme.titleSmall,
            ),
          );
        },
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: AppColor.primaryColor,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: AppColor.primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      calendarFormat: CalendarFormat.month,
    );
  }
}
