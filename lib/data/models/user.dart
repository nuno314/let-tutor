import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/common/constants.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? email;
  String? name;
  @JsonKey(name: 'avatar')
  String? avatar;
  String? country;
  @JsonKey(name: 'phone')
  String? phoneNumber;
  bool? isPhoneActivated;
  String? birthday;
  String? level;
  List<LearnTopic>? learnTopics;
  List<Test>? testPreparations;
  List<Specialty>? specialties;
  String? requireNote;
  User({
    this.id,
    this.name,
    this.avatar,
    this.email,
    this.country,
    this.phoneNumber,
    this.isPhoneActivated,
    this.birthday,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.specialties,
    this.requireNote,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  Map<String, dynamic> toBody() => <String, dynamic>{
        'name': this.name,
        'avatar': this.avatar,
        'country': this.country,
        'phone': this.phoneNumber,
        'birthday': this.birthday,
        'level': this.level,
        'learnTopics': this.specialties?.map((e) => e.learnTopicCode).toList()
          ?..removeWhere((element) => element == null),
        'testPreparations':
            this.specialties?.map((e) => e.testPreparationCode).toList()
              ?..removeWhere((element) => element == null),
        'requireNote': this.requireNote,
      };

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? avatar,
    String? country,
    String? phoneNumber,
    bool? isPhoneActivated,
    String? birthday,
    String? level,
    List<LearnTopic>? learnTopics,
    List<Test>? testPreparations,
    String? requireNote,
    List<Specialty>? specialties,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      country: country ?? this.country,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPhoneActivated: isPhoneActivated ?? this.isPhoneActivated,
      birthday: birthday ?? this.birthday,
      level: level ?? this.level,
      learnTopics: learnTopics ?? this.learnTopics,
      testPreparations: testPreparations ?? this.testPreparations,
      requireNote: requireNote ?? this.requireNote,
      specialties: specialties ?? this.specialties,
    );
  }

  String get wantToLearn {
    int cnt = 0;
    String res = '';
    for (LearnTopic topic in learnTopics ?? []) {
      if (cnt != 0) {
        res += ', ';
      }
      res += topic.name ?? '';
      cnt++;
    }
    for (Test test in testPreparations ?? []) {
      if (cnt != 0) {
        res += ', ';
      }
      res += test.name ?? '';
      cnt++;
    }
    return res;
  }
}

@JsonSerializable()
class LearnTopic {
  int? id;
  String? key;
  String? name;

  LearnTopic({this.id, this.key, this.name});

  factory LearnTopic.fromJson(Map<String, dynamic> json) =>
      _$LearnTopicFromJson(json);

  Map<String, dynamic> toJson() => _$LearnTopicToJson(this);
}

@JsonSerializable()
class Test {
  int? id;
  String? key;
  String? name;

  Test({this.id, this.key, this.name});

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);

  Map<String, dynamic> toJson() => _$TestToJson(this);
}
