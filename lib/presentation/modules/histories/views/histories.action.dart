part of 'histories_screen.dart';

class FeedbackTutorResult {
  final int rating;
  final String? content;

  FeedbackTutorResult({
    required this.rating,
    this.content,
  });
}

class ReportTutorResult {}

extension HistoriesAction on _HistoriesScreenState {
  void _blocListener(BuildContext context, HistoriesState state) {
    hideLoading();

    if (state is FeedbackTutorState) {
      controller.requestRefresh();
    }
  }

  void onRefresh() {
    bloc.add(GetHistoriesEvent());
  }

  void onLoading() {
    bloc.add(LoadMoreHistoriesEvent());
  }

  void onTapRating(BookingInfo booking) {
    var rating = 5;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final controller = InputContainerController();

          return AlertDialog(
            title: Text(
              trans.addARating,
              style:
                  textTheme.bodyLarge?.copyWith(color: AppColor.primaryColor),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    5,
                    (index) => InkWell(
                      onTap: () {
                        setState(() {
                          rating = index + 1;
                        });
                      },
                      child: _buildRating(
                        index < rating ? AppColor.yellowFADB14 : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InputContainer(
                  controller: controller,
                  title: trans.notes,
                  titleStyle: textTheme.bodyLarge,
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
                          FeedbackTutorResult(
                            rating: rating,
                            content: controller.text,
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
      hideKeyBoard();
      if (value is FeedbackTutorResult) {
        bloc.add(
          RateBookingEvent(
            rating: value.rating,
            bookingId: booking.id!,
            content: value.content,
          ),
        );
      }
    });
  }

  void onTapReport(BookingInfo booking) {}
}
