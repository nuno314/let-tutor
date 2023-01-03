part of 'profile_screen.dart';

extension ProfileAction on _ProfileScreenState {
  void _blocListener(BuildContext context, ProfileState state) {
    _nameController.text = state.user?.name;
    _emailController.text = state.user?.email;
    _countryController.text = state.user?.country;
    _phoneNumberController.text = state.user?.phoneNumber;
    _dobController.text = state.user?.birthday;
    _levelController.text = state.user?.level;
    _wantToLearnController.text = state.user?.wantToLearn;
    avatarValue.value = state.user?.avatar;
    _scheduleController.text = state.user?.requireNote;

    if (state is UpdateProfileSuccess) {
      hideLoading();
      Navigator.pop(context, state.user);
    }
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
              children: LevelEnum.values.map((e) {
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
                      e.description(),
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
    ).then((value) {
      if (value is LevelEnum) {
        _levelController.text = value.toJson();
      }
    });
  }

  void showWantToLearnDialog() {
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
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: subjects.map((e) {
                    final index = subjects.indexOf(e);
                    return InkWell(
                      onTap: () => setState(
                        () {
                          selectedSubjects[index] = !selectedSubjects[index];
                        },
                      ),
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
                          e.localized(trans),
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
                const Spacer(),
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
                              wantToLearn += sj.localized(trans);
                              cnt++;
                              specialties.add(sj);
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

  void showSelectNationDialog() {
    final countries = Countries.all();
    hideKeyBoard();
    showDialog(
      context: context,
      builder: (ctx) {
        return buildDialogSelection<Country>(
          countries,
          (item) => item.name!,
          (p0) => _countryController.text = p0.name,
        );
      },
    );
  }

  SelectionDialog buildDialogSelection<T>(
    List<T> items,
    String Function(T) getName,
    Function(T) onSelected,
  ) {
    return SelectionDialog<T>(
      items: items,
      itemBuilder: (ctx, value) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 4,
          ),
          child: Text(
            getName(value),
            style: textTheme.subtitle2?.copyWith(
              color: Colors.black,
            ),
          ),
        );
      },
      filterFn: (it, filter) {
        return getName(it)
            .toLowerCase()
            .removeDiacritics
            .contains(filter!.toLowerCase().removeDiacritics);
      },
      onSelected: (item) {
        onSelected.call(item);
        Navigator.of(context).pop();
      },
    );
  }

  bool validate() {
    if (_nameController.text.isNullOrEmpty) {
      _nameController.setError(trans.invalidName);
      return false;
    }
    if (_countryController.text.isNullOrEmpty) {
      _countryController.setError(trans.invalidCountry);
      return false;
    }
    if (_dobController.text.isNullOrEmpty) {
      _dobController.setError(trans.invalidBirthday);
      return false;
    }
    if (_levelController.text.isNullOrEmpty) {
      _levelController.setError(trans.invalidLevel);
      return false;
    }
    if (_wantToLearnController.text.isNullOrEmpty) {
      _wantToLearnController.setError(trans.invalidWantToLearn);
      return false;
    }
    return true;
  }

  void saveChanges(User? user) {
    if (validate() == true) {
      showLoading();
      bloc.add(
        UpdateProfileEvent(
          user!.copyWith(
            name: _nameController.text,
            country: _countryController.text,
            phoneNumber: _phoneNumberController.text,
            birthday: _dobController.text,
            level: _levelController.text,
            specialties: specialties,
            requireNote: _scheduleController.text,
          ),
        ),
      );
    }
  }
}
