part of 'histories_screen.dart';

class FeedbackTutorResult {
  final int rating;
  final String? content;

  FeedbackTutorResult({
    required this.rating,
    this.content,
  });
}

extension HistoriesAction on _HistoriesScreenState {
  void onRefresh() async {
    await provider.getHistoriesEvent();
    hideLoading();
  }

  void onLoading() async {
    await provider.loadMoreHistoriesEvent();
    hideLoading();
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
    ).then((value) async {
      if (value is FeedbackTutorResult) {
        final res = await provider.rateBookingEvent(
          rating: value.rating,
          bookingId: booking.id!,
          content: value.content,
        );
        if (res) {
          controller.requestRefresh();
        }
      }
    });
  }

  void onTapReport(BookingInfo booking) {}
}
