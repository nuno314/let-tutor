// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: json['id'] as String?,
      walletId: json['walletId'] as String?,
      bookingId: json['bookingId'] as String?,
      price: json['price'] as String?,
      revenue: json['revenue'] as String?,
      status: json['status'] as String?,
      type: PaymentTypeEtx.of(json['type']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      bookingInfo: json['bookingInfo'] == null
          ? null
          : BookingInfo.fromJson(json['bookingInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'walletId': instance.walletId,
      'bookingId': instance.bookingId,
      'price': instance.price,
      'revenue': instance.revenue,
      'status': instance.status,
      'type': PaymentTypeEtx.toJson(instance.type),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'bookingInfo': instance.bookingInfo,
    };

BookingInfo _$BookingInfoFromJson(Map<String, dynamic> json) => BookingInfo(
      id: json['id'] as String?,
      scheduleDetailId: json['scheduleDetailId'] as String?,
      tutorMeetingLink: json['tutorMeetingLink'] as String?,
      studentMeetingLink: json['studentMeetingLink'] as String?,
      studentRequest: json['studentRequest'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      schedule: json['scheduleDetailInfo'] == null
          ? null
          : Schedule.fromJson(
              json['scheduleDetailInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingInfoToJson(BookingInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduleDetailId': instance.scheduleDetailId,
      'tutorMeetingLink': instance.tutorMeetingLink,
      'studentMeetingLink': instance.studentMeetingLink,
      'studentRequest': instance.studentRequest,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt?.toIso8601String(),
      'scheduleDetailInfo': instance.schedule,
    };

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      amount: json['amount'] as String?,
      isBlocked: json['isBlocked'] as bool?,
      bonus: json['bonus'] as int?,
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'amount': instance.amount,
      'isBlocked': instance.isBlocked,
      'bonus': instance.bonus,
    };
