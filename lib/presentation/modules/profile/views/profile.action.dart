part of 'profile_screen.dart';

extension ProfileAction on _ProfileScreenState {
  void _blocListener(BuildContext context, ProfileState state) {
    _nameController.text = state.user?.name;
    _emailController.text = state.user?.email;
    _countryController.text = state.user?.country;
    _phoneNumberController.text = state.user?.phoneNumber;
    _dobController.text = state.user?.birthday;
    _levelController.text = state.user?.level;
    avatarValue.value = state.user?.avatar;
  }

  void _showBirthdayPicker() {
    showCupertinoCustomDatePicker(
      context,
      _pickBirthday ?? DateTime.now(),
      (DateTime? newDate) {
        _pickBirthday = newDate;
        _dobController.setText = newDate?.toNormalDateFormat() ?? '';
      },
      maxDate: DateTime.now(),
    );
  }

  void loadData() {
    bloc.add(GetProfileEvent());
  }

  void showLevelDialog() {
    List<String> levels = [
      'Pre A1 (Beginner)',
      'A1 (High Beginner)',
      'A2 (Pre-Intermediate)',
      'B1 (Intermediate)',
      'B2 (Upper-Intermediate)',
      'C1 (Advanced)',
      'C2(Proficiency)',
    ];
    showDialog(
      useRootNavigator: true,
      useSafeArea: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(trans.level),
          content: Container(
            constraints: BoxConstraints(maxHeight: 200),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: levels.map((e) {
                return InkWell(
                  onTap: () => Navigator.pop(context, e),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      color: AppColor.white,
                    ),
                    child: Text(
                      e,
                      style: textTheme.bodyText1?.copyWith(
                        color: AppColor.primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    ).then((value) => _levelController.text = value);
  }

  void showWantToLearnDialog() {
    List<String> subjects = [
      'English for Kids',
      'Business English',
      'Conversational English',
    ];
    List<bool> selectedSubjects = [
      false,
      false,
      false,
    ];
    List<String> testPreparations = [
      'STARTERS',
      'MOVERS',
      'FLYERS',
      'KET',
      'PET',
      'IELTS',
      'TOEFL',
      'TOEIC',
    ];
    List<bool> selectedTest = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ];
    showDialog(
      useRootNavigator: true,
      useSafeArea: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(trans.wantToLearn),
          content: Container(
            constraints: BoxConstraints(maxHeight: 300),
            child: Column(
              children: [
                Text(
                  trans.subjects,
                  style: textTheme.bodyText1?.copyWith(
                    color: AppColor.grayAD,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: subjects.map((e) {
                    final index = subjects.indexOf(e);
                    return InkWell(
                      onTap: () => setState(() {
                        selectedSubjects[index] = !selectedSubjects[index];
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          color: selectedSubjects[index]
                              ? AppColor.primaryColor
                              : AppColor.white,
                        ),
                        child: Text(
                          e,
                          style: textTheme.bodyText1?.copyWith(
                            color: selectedSubjects[index]
                                ? AppColor.white
                                : AppColor.primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  trans.testPreparation,
                  style: textTheme.bodyText1?.copyWith(
                    color: AppColor.grayAD,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: testPreparations.map((e) {
                    final index = testPreparations.indexOf(e);
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedTest[index] = !selectedTest[index];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          color: selectedTest[index]
                              ? AppColor.primaryColor
                              : AppColor.white,
                        ),
                        child: Text(
                          e,
                          style: textTheme.bodyText1?.copyWith(
                            color: selectedTest[index]
                                ? AppColor.white
                                : AppColor.primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ThemeButton.outline(
                        context: context,
                        title: trans.cancel,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ThemeButton.primary(
                        context: context,
                        title: trans.confirm,
                        onPressed: () {
                          int cnt = 0;
                          String wantToLearn = '';
                          for (final sj in subjects) {
                            if (selectedSubjects[subjects.indexOf(sj)] ==
                                true) {
                              if (cnt != 0) {
                                wantToLearn += ', ';
                              }
                              wantToLearn += sj;
                              cnt++;
                            }
                          }
                          _wantToLearnController.text = wantToLearn;
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ).then((value) {});
  }

  void saveChanges() {
    Navigator.pop(context);
  }
}
