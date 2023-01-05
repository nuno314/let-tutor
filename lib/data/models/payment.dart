import 'package:json_annotation/json_annotation.dart';

import 'package:let_tutor/data/models/schedule.dart';

import '../../common/constants.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  String? id;
  String? walletId;
  String? bookingId;
  String? price;
  String? revenue;
  String? status;
  @JsonKey(
    name: 'type',
    fromJson: PaymentTypeEtx.of,
    toJson: PaymentTypeEtx.toJson,
  )
  PaymentType? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  BookingInfo? bookingInfo;
  Payment({
    this.id,
    this.walletId,
    this.bookingId,
    this.price,
    this.revenue,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.bookingInfo,
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  bool get isBook => type == PaymentType.buy;
}

@JsonSerializable()
class BookingInfo {
  String? id;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  bool? isDeleted;
  DateTime? createdAt;
  @JsonKey(name: 'scheduleDetailInfo')
  Schedule? schedule;
  BookingInfo({
    this.id,
    this.scheduleDetailId,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.isDeleted,
    this.createdAt,
    this.schedule,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) =>
      _$BookingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BookingInfoToJson(this);
}

@JsonSerializable()
class Wallet {
  String? amount;
  bool? isBlocked;
  int? bonus;
  Wallet({
    this.amount,
    this.isBlocked,
    this.bonus,
  });
  factory Wallet.fromJson(Map<String, dynamic> json) =>
      _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
