part of 'register_tutor_screen.dart';

extension RegisterTutorAction on _RegisterTutorScreenState {
  void _blocListener(BuildContext context, RegisterTutorState state) {}
  void tapEditAvatar() {}

  void showSelectLanguagesDialog() {
    final List<String> countries = Languages.defaultLanguagesList;
    hideKeyBoard();
    showDialog(
      context: context,
      builder: (ctx) {
        return buildDialogSelection<String>(
          countries,
          (item) => item,
          (p0) => _languagesController.text!.isEmpty
              ? _languagesController.text = p0
              : _languagesController.text =
                  _languagesController.text! + ', ' + p0,
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
            style: textTheme.titleSmall?.copyWith(
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
    if (_nameController.text?.isNullOrEmpty == true) {
      _nameController.setError(trans.invalidName);
      return false;
    }
    if (_nationalityController.text.isNullOrEmpty == true) {
      _nationalityController.setError(trans.invalidCountry);
      return false;
    }
    if (_dobController.text.isNullOrEmpty == true) {
      _dobController.setError(trans.invalidBirthday);
      return false;
    }
    if (_interestsController.text.isNullOrEmpty == true) {
      _interestsController.setError(trans.pleaseNoEmpty);
      return false;
    }
    if (_educationController.text.isNullOrEmpty == true) {
      _educationController.setError(trans.pleaseNoEmpty);
      return false;
    }
    if (_experienceController.text.isNullOrEmpty == true) {
      _experienceController.setError(trans.pleaseNoEmpty);
      return false;
    }
    if (_professionController.text.isNullOrEmpty == true) {
      _professionController.setError(trans.pleaseNoEmpty);
      return false;
    }
    if (_languagesController.text.isNullOrEmpty == true) {
      _languagesController.setError(trans.pleaseNoEmpty);
      return false;
    }
    if (_introductionController.text.isNullOrEmpty == true) {
      _introductionController.setError(trans.pleaseNoEmpty);
      return false;
    }

    return true;
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

  void onNext() {
    if (validate())
      Navigator.pushNamed(context, RouteList.registerTutorIntroVideo)
          .then((value) {
        if (value == true) {
          bloc.add(RegisterTutorSuccessEvent(
            bio: _introductionController.text,
            education: _educationController.text,
            experience: _educationController.text,
            interests: _interestsController.text,
            languages: _languagesController.text,
            profression: _professionController.text,
            specialties: specialties.map((e) => e.name).join(','),
            targetStudent: _selectedLevel.description(),
          ));
          Navigator.pop(context);
        }
      });
  }
}
