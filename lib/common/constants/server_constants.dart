part of '../constants.dart';

class ServerGender {
  static const String male = 'Male';
  static const String female = 'Female';
  static const String other = 'Other';
}

class ServerScanStatus {
  static const String scanSuccess = 'scan-success';
  static const String scanFailed = 'scan-failed';
}

class ServerNotification {
  static const String manualType = 'manual';
  static const String newsType = 'news';
}

class ServerNotificationManual {
  static const String point = 'point';
  static const String reminder = 'reminder';
  static const String scan = 'scan';
  static const String upgrade = 'upgrade';
}

class ServerErrorCode {
  static const String invalidToken = 'invalid_token';
  static const String userNotFound = 'user_not_found';
}

class SystemRole {
  static const String daikinDealerID = 'f55d5990-bea4-4331-9d58-6e223e58f54a';
  static const String subDealerID = '472cc1cc-a082-4c99-82e3-e58ab27248c3';
  static const String daikinDealerAlias = 'daikin_dealer';
  static const String subDealerAlias = 'sub_dealer';
  static const String freelancerAlias = 'freelancer';
  static const String guestAlias = 'guest';
}

class UpgradeStatus {
  static const String done = 'done';
  static const String requesting = 'requesting';
  static const String approve = 'approve';
  static const String rejected = 'rejected';
  static const String pending = 'pending';
}

class PointStatus {
  static const String earn = 'earn';
  static const String redeem = 'redeem';
  static const String expired = 'expired';
}

class Status {
  static const String active = 'active';
}

class PointType {
  static const String point = 'point';
  static const String money = 'money';
}

class RewardType {
  static const String static = 'static';
  static const String dynamic = 'dynamic';
}

class ScanProductMode {
  static const String qrCode = 'qrCode';
  static const String barCode = 'barCode';
  static const String all = 'all';
}

enum LevelEnum {
  beginner,
  higherBeginner,
  preIntermediate,
  intermediate,
  upperIntermediate,
  advanced,
  proficiency,
}

extension LevelEnumEtx on LevelEnum {
  String toJson() {
    switch (this) {
      case LevelEnum.beginner:
        return 'BEGINNER';
      case LevelEnum.higherBeginner:
        return 'HIGHER_BEGINNER';
      case LevelEnum.preIntermediate:
        return 'PRE_INTERMEDIATE';
      case LevelEnum.intermediate:
        return 'INTERMEDIATE';
      case LevelEnum.upperIntermediate:
        return 'UPPER_INTERMEDIATE';
      case LevelEnum.advanced:
        return 'ADVANCED';
      case LevelEnum.proficiency:
        return 'PROFICIENCY';
    }
  }

  String description() {
    switch (this) {
      case LevelEnum.beginner:
        return 'Pre A1 (Beginner)';
      case LevelEnum.higherBeginner:
        return 'A1 (High Beginner)';
      case LevelEnum.preIntermediate:
        return 'A2 (Pre-Intermediate)';
      case LevelEnum.intermediate:
        return 'B1 (Intermediate)';
      case LevelEnum.upperIntermediate:
        return 'B2 (Upper-Intermediate)';
      case LevelEnum.advanced:
        return 'C1 (Advanced)';
      case LevelEnum.proficiency:
        return 'C2(Proficiency)';
    }
  }
}

extension LearnTopicEtx on LearnTopic {
  static List<LearnTopic> getAll() {
    return [
      LearnTopic(id: 1, key: '', name: 'English for Kids'),
      LearnTopic(id: 2, key: '', name: 'Business English'),
      LearnTopic(id: 3, key: '', name: 'Conversational English')
    ];
  }
}

extension TestPreparations on Test {
  static List<Test> getAll() {
    return [
      Test(id: 1, key: 'starters', name: 'STARTERS'),
      Test(id: 2, key: 'movers', name: 'MOVERS'),
      Test(id: 3, key: 'flyers', name: 'FLYERS'),
      Test(id: 4, key: 'ket', name: 'KET'),
      Test(id: 5, key: 'pet', name: 'PET'),
      Test(id: 6, key: 'ielts', name: 'IELTS'),
      Test(id: 7, key: 'toefl', name: 'TOEFL'),
      Test(id: 8, key: 'toeic', name: 'TOEIC'),
    ];
  }
}

enum PaymentType {
  buy,
  cancel,
}

extension PaymentTypeEtx on PaymentType {
  static String? toJson(PaymentType? s) {
    return s?.type;
  }

  String get type {
    switch (this) {
      case PaymentType.buy:
        return 'buy';
      case PaymentType.cancel:
        return 'cancel';
    }
  }

  static PaymentType? of(dynamic value) {
    final type = asOrNull<String>(value);
    for (final e in PaymentType.values) {
      if (e.type == type) {
        return e;
      }
    }
    return null;
  }

  String localized(dynamic trans) {
    switch (this) {
      case PaymentType.buy:
        return trans.book;
      case PaymentType.cancel:
        return trans.cancelBooking;
    }
  }
}
