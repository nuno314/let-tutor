part of 'schedule_screen.dart';

class CancelBookingResult {
  final bool res;
  final int? reason;
  final String? notes;

  CancelBookingResult({
    required this.res,
    required this.reason,
    required this.notes,
  });
}

extension ScheduleAction on _ScheduleScreenState {
  void _blocListener(BuildContext context, ScheduleState state) {
    controller
      ..refreshCompleted()
      ..loadComplete();
    if (state is CancelBookingState) {
      controller.requestRefresh();
    }
  }

  void onRefresh() {
    bloc.add(GetScheduleEvent());
  }

  void onLoading() {
    bloc.add(LoadMoreScheduleEvent());
  }

  void onBookSchedule() {}

  void onTapCancel(BookingInfo booking) {
    final choices = [
      trans.rescheduleAtAnotherTime,
      trans.busyAtThatTime,
      trans.askedByTheTutor,
      trans.other
    ];
    var reason = choices.first;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final controller = InputContainerController();
          return AlertDialog(
            title: Text(
              trans.cancelBooking,
              style: textTheme.bodyText1?.copyWith(color: AppColor.red),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  trans.whatWasTheReason,
                  style: textTheme.bodyText1?.copyWith(fontSize: 14),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: reason,
                    icon: const Icon(Icons.expand_circle_down_outlined),
                    elevation: 16,
                    style: textTheme.bodyText2
                        ?.copyWith(fontSize: 14, color: AppColor.gray8C),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        reason = value!;
                      });
                    },
                    items:
                        choices.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(),
                InputContainer(
                  controller: controller,
                  title: trans.notes,
                  titleStyle: textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ThemeButton.outline(
                        context: context,
                        title: trans.cancel,
                        onPressed: () => Navigator.pop(
                          context,
                          CancelBookingResult(
                            res: false,
                            reason: 0,
                            notes: '',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ThemeButton.primary(
                        context: context,
                        title: trans.confirm,
                        onPressed: () => Navigator.pop(
                          context,
                          CancelBookingResult(
                            res: true,
                            reason: choices.indexOf(reason) + 1,
                            notes: controller.text,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    ).then((value) {
      if (value is CancelBookingResult && value.res == true) {
        bloc.add(CancelBookingEvent(
          id: booking.id!,
          reason: value.reason!,
          notes: value.notes ?? '',
        ));
      }
    });
  }

  void onTapJoinMeeting(BookingInfo elementAt) {}
}
