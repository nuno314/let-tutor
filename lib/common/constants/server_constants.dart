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

enum Specialty {
  all,
  kidEnglish,
  businessEnglish,
  conversational,
  starters,
  movers,
  flyers,
  ket,
  pet,
  ielts,
  toefl,
  toeic,
  ;

  static Map<String, Specialty> jsonMap = {
    'english-for-kids': kidEnglish,
    'business-english': businessEnglish,
    'conversational-english': conversational,
    'starters': starters,
    'movers': movers,
    'flyers': flyers,
    'ket': ket,
    'pet': pet,
    'ielts': ielts,
    'toefl': toefl,
    'toeic': toeic,
  };

  String get id {
    final Map<Specialty, String> map = {
      all: 'all',
      kidEnglish: 'english-for-kids',
      businessEnglish: 'business-english',
      conversational: 'conversational-english',
      starters: 'starters',
      movers: 'movers',
      flyers: 'flyers',
      ket: 'ket',
      pet: 'pet',
      ielts: 'ielts',
      toefl: 'toefl',
      toeic: 'toeic',
    };
    return map[this]!;
  }

  String? get learnTopicCode {
    final Map<Specialty, String?> map = {
      all: '0',
      kidEnglish: '3',
      businessEnglish: '4',
      conversational: '5',
    };
    return map[this] ?? null;
  }

  String? get testPreparationCode {
    final Map<Specialty, String?> map = {
      starters: '1',
      movers: '2',
      flyers: '3',
      ket: '4',
      pet: '5',
      ielts: '6',
      toefl: '7',
      toeic: '8',
    }..removeWhere((key, value) => value == null);
    return map[this] ?? null;
  }

  String localized(AppLocalizations trans) {
    switch (this) {
      case Specialty.all:
        return trans.all;
      case Specialty.kidEnglish:
        return trans.englishForKids;
      case Specialty.businessEnglish:
        return trans.englishForBusiness;
      case Specialty.conversational:
        return trans.conversational;
      case Specialty.starters:
        return trans.starters;
      case Specialty.movers:
        return trans.movers;
      case Specialty.flyers:
        return trans.flyers;
      case Specialty.ket:
        return trans.ket;
      case Specialty.pet:
        return trans.pet;
      case Specialty.ielts:
        return trans.ielts;
      case Specialty.toefl:
        return trans.toefl;
      case Specialty.toeic:
        return trans.toeic;
    }
  }
}

enum TutorNationality {
  foreign,
  vietnamese,
  native,
}

extension TutorNationalityExt on TutorNationality {
  Map<String, dynamic> get toJson {
    switch (this) {
      case TutorNationality.foreign:
        return {
          'isVietnamese': false,
          'isNative': false,
        };
      case TutorNationality.vietnamese:
        return {
          'isVietnamese': true,
        };
      case TutorNationality.native:
        return {
          'isNative': true,
        };
    }
  }

  String localized(AppLocalizations trans) {
    switch (this) {
      case TutorNationality.foreign:
        return trans.foreignTutor;
      case TutorNationality.vietnamese:
        return trans.vietnameseTutor;
      case TutorNationality.native:
        return trans.nativeEnglishTutor;
    }
  }
}

class Languages {
  static final List<String> defaultLanguagesList = [
    "Abkhazian",
    "Afar",
    "Afrikaans",
    "Akan",
    "Albanian",
    "Amharic",
    "Arabic",
    "Aragonese",
    "Armenian",
    "Assamese",
    "Avaric",
    "Avestan",
    "Aymara",
    "Azerbaijani",
    "Bambara",
    "Bashkir",
    "Basque",
    "Belarusian",
    "Bengali",
    "Bihari Languages",
    "Bislama",
    "Norwegian",
    "Bosnian",
    "Breton",
    "Bulgarian",
    "Burmese",
    "Catalan",
    "Central Khmer",
    "Chamorro",
    "Chechen",
    "Chewa (Nyanja)",
    "Chinese (Simplified)",
    "Chinese (Traditional)",
    "Church Slavonic",
    "Chuvash",
    "Cornish",
    "Corsican",
    "Cree",
    "Croatian",
    "Czech",
    "Danish",
    "Dhivehi",
    "Dutch",
    "Dzongkha",
    "English",
    "English",
    "Esperanto",
    "Estonian",
    "Ewe",
    "Faroese",
    "Fijian",
    "Finnish",
    "French",
    "Fulah",
    "Gaelic",
    "Galician",
    "Ganda",
    "Georgian",
    "German",
    "Greek, Modern (1453-)",
    "Guarani",
    "Gujarati",
    "Haitian",
    "Hausa",
    "Hebrew",
    "Herero",
    "Hindi",
    "Hiri Motu",
    "Hungarian",
    "Icelandic",
    "Ido",
    "Igbo",
    "Indonesian",
    "Interlingua",
    "Interlingue",
    "Inuktitut",
    "Inupiaq",
    "Irish",
    "Italian",
    "Japanese",
    "Javanese",
    "Kalaallisut",
    "Kannada",
    "Kanuri",
    "Kashmiri",
    "Kazakh",
    "Kikuyu",
    "Kinyarwanda",
    "Kirghiz",
    "Komi",
    "Kongo",
    "Korean",
    "Kuanyama",
    "Kurdish",
    "Lao",
    "Latin",
    "Latvian",
    "Limburgan",
    "Lingala",
    "Lithuanian",
    "Luba-Katanga",
    "Luxembourgish",
    "Macedonian",
    "Malagasy",
    "Malay",
    "Malayalam",
    "Maltese",
    "Manx",
    "Maori",
    "Marathi",
    "Marshallese",
    "Mongolian",
    "Nauru",
    "Navajo",
    "Ndebele, North",
    "Ndebele, South",
    "Ndonga",
    "Nepali",
    "Northern Sami",
    "Norwegian",
    "Norwegian Nynorsk",
    "Occitan (post 1500)",
    "Ojibwa",
    "Oriya",
    "Oromo",
    "Ossetian",
    "Pali",
    "Panjabi",
    "Persian",
    "Polish",
    "Portuguese",
    "Pushto",
    "Quechua",
    "Romanian",
    "Romansh",
    "Rundi",
    "Russian",
    "Samoan",
    "Sango",
    "Sanskrit",
    "Sardinian",
    "Serbian",
    "Shona",
    "Sichuan Yi",
    "Sindhi",
    "Sinhala",
    "Slovak",
    "Slovenian",
    "Somali",
    "Sotho, Southern",
    "Spanish",
    "Sundanese",
    "Swahili",
    "Swati",
    "Swedish",
    "Tagalog",
    "Tahitian",
    "Tajik",
    "Tamil",
    "Tatar",
    "Telugu",
    "Thai",
    "Tibetan",
    "Tigrinya",
    "Tonga (Tonga Islands)",
    "Tsonga",
    "Tswana",
    "Turkish",
    "Turkmen",
    "Twi",
    "Uighur",
    "Ukrainian",
    "Urdu",
    "Uzbek",
    "Venda",
    "Vietnamese",
    "Volapük",
    "Walloon",
    "Welsh",
    "Western Frisian",
    "Wolof",
    "Xhosa",
    "Yiddish",
    "Yoruba",
    "Zhuang",
    "Zulu",
  ];
}
