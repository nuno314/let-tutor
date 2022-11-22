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
    avatarValue.notifyListeners();
    print('emit');
  }

  void loadData() {
    bloc.add(GetProfileEvent());
  }

  void fillData() {}

  void saveChanges() {
    Navigator.pop(context);
  }
}
