part of 'histories_bloc.dart';

abstract class HistoriesEvent {}

class GetHistoriesEvent extends HistoriesEvent {}

class LoadMoreHistoriesEvent extends HistoriesEvent {}

class RateBookingEvent extends HistoriesEvent {
  final int rating;
  final String? content;
  final String bookingId;

  RateBookingEvent({
    required this.rating,
    this.content,
    required this.bookingId,
  });
}
